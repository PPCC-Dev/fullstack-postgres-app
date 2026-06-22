import pool from '../config/db.js';

export const getSummaryReport = async (req, res) => {
  const { filter, custNum } = req.query; // 'daily', 'weekly', 'monthly', or 'all'
  let dateFilter = '';
  
  if (filter === 'daily') {
    dateFilter = "AND created_at >= CURRENT_DATE";
  } else if (filter === 'weekly') {
    dateFilter = "AND created_at >= CURRENT_DATE - INTERVAL '7 days'";
  } else if (filter === 'monthly') {
    dateFilter = "AND created_at >= CURRENT_DATE - INTERVAL '1 month'";
  }

  let customerFilter = '';
  const queryParams = [];
  if (custNum && custNum !== 'all') {
    queryParams.push(custNum);
    customerFilter = `AND t.cust_num = $1`;
  }

  try {
    // Fetch all tickets for the period with customer and agent info
    const ticketsQuery = `
      SELECT t.*, 
             COALESCE(pt.name, t.program_type) as program_type,
             c.name as customer_name, c.cust_num as customer_cust_num,
             a.name as agent_name,
             r.name as resolver_name,
             cust.cust_name as actual_customer_name,
             ss.description as status_description
      FROM tickets t
      LEFT JOIN users c ON t.customer_id = c.id
      LEFT JOIN users a ON t.agent_id = a.id
      LEFT JOIN users r ON t.resolved_by = r.id
      LEFT JOIN program_types pt ON t.program_type = pt.value
      LEFT JOIN customers cust ON t.cust_num = cust.cust_num
      LEFT JOIN support_stats ss ON t.status = ss.stat
      WHERE 1=1 ${dateFilter.replace('created_at', 't.created_at')} ${customerFilter}
      ORDER BY t.created_at DESC
    `;
    const ticketsResult = await pool.query(ticketsQuery, queryParams);
    const tickets = ticketsResult.rows;

    const totalCases = tickets.length;
    
    const activeTickets = tickets.filter(t => ['open', 'assigned', 'O', 'I'].includes(t.status));
    const activeCases = activeTickets.length;

    const closedTickets = tickets.filter(t => ['resolved', 'C'].includes(t.status));
    const closedCases = closedTickets.length;

    // Calculate average resolution time using DB for accuracy on resolved_at
    const avgParams = [];
    let avgCustomerFilter = '';
    if (custNum && custNum !== 'all') {
      avgParams.push(custNum);
      avgCustomerFilter = `AND cust_num = $1`;
    }
    const avgTimeResult = await pool.query(`
      SELECT AVG(EXTRACT(EPOCH FROM (resolved_at - created_at))) as avg_seconds
      FROM tickets 
      WHERE status IN ('resolved', 'C') AND resolved_at IS NOT NULL ${dateFilter} ${avgCustomerFilter}
    `, avgParams);
    
    const avgSeconds = avgTimeResult.rows[0].avg_seconds ? parseFloat(avgTimeResult.rows[0].avg_seconds) : 0;
    
    return res.status(200).json({
      totalCases,
      activeCases,
      closedCases,
      avgResolutionSeconds: avgSeconds,
      tickets,
      activeTickets,
      closedTickets
    });

  } catch (error) {
    console.error('Error fetching report summary:', error);
    return res.status(500).json({ error: 'Server error while fetching report summary.' });
  }
};
