<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <title>Expense Tracker Pro</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            color: #2d3748;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        .header {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            text-align: center;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .header h1 {
            font-size: 2.5rem;
            font-weight: 800;
            background: linear-gradient(135deg, #667eea, #764ba2);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 10px;
        }

        .header .subtitle {
            color: #64748b;
            font-size: 1.1rem;
            margin-bottom: 20px;
        }

        .stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 16px;
            padding: 25px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
        }

        .stat-card .icon {
            width: 50px;
            height: 50px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            margin-bottom: 15px;
        }

        .total-expense .icon {
            background: linear-gradient(135deg, #ff6b6b, #ee5a24);
            color: white;
        }

        .expense-count .icon {
            background: linear-gradient(135deg, #4ecdc4, #44a08d);
            color: white;
        }

        .stat-card h3 {
            font-size: 0.9rem;
            color: #64748b;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 5px;
        }

        .stat-card .value {
            font-size: 2rem;
            font-weight: 800;
            color: #1a202c;
        }

        .controls {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            flex-wrap: wrap;
            gap: 15px;
        }

        .search-filter {
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
            flex: 1;
        }

        .search-box {
            position: relative;
            flex: 1;
            min-width: 200px;
        }

        .search-box input {
            width: 100%;
            padding: 12px 40px 12px 16px;
            border: 2px solid rgba(255, 255, 255, 0.3);
            border-radius: 12px;
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(10px);
            font-size: 0.95rem;
            transition: all 0.3s ease;
        }

        .search-box input:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .search-box i {
            position: absolute;
            right: 12px;
            top: 50%;
            transform: translateY(-50%);
            color: #64748b;
        }

        .filter-select {
            padding: 12px 16px;
            border: 2px solid rgba(255, 255, 255, 0.3);
            border-radius: 12px;
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(10px);
            font-size: 0.95rem;
            min-width: 150px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .filter-select:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .add-expense-btn {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            padding: 12px 24px;
            border: none;
            border-radius: 12px;
            font-weight: 600;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
        }

        .add-expense-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);
            text-decoration: none;
            color: white;
        }

        .table-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        thead {
            background: linear-gradient(135deg, #2d3748, #4a5568);
            color: white;
        }

        th {
            padding: 20px 24px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-size: 0.85rem;
        }

        tbody tr {
            transition: all 0.3s ease;
            border-bottom: 1px solid rgba(226, 232, 240, 0.5);
        }

        tbody tr:hover {
            background: rgba(102, 126, 234, 0.05);
            transform: scale(1.01);
        }

        tbody tr:last-child {
            border-bottom: none;
        }

        td {
            padding: 18px 24px;
            font-size: 0.95rem;
        }

        .amount-cell {
            font-weight: 700;
            color: #e53e3e;
            font-size: 1.1rem;
        }

        .category-badge {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .category-food { background: #fed7d7; color: #c53030; }
        .category-transport { background: #bee3f8; color: #2b6cb0; }
        .category-entertainment { background: #d6f5d6; color: #276749; }
        .category-utilities { background: #feebc8; color: #c05621; }
        .category-other { background: #e2e8f0; color: #4a5568; }

        .actions {
            display: flex;
            gap: 10px;
            align-items: center;
        }

        .action-btn {
            padding: 8px 12px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 500;
            font-size: 0.85rem;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 4px;
        }

        .edit-btn {
            background: #e6fffa;
            color: #234e52;
            border: 1px solid #81e6d9;
        }

        .edit-btn:hover {
            background: #81e6d9;
            color: white;
            text-decoration: none;
        }

        .delete-btn {
            background: #fed7d7;
            color: #c53030;
            border: 1px solid #feb2b2;
        }

        .delete-btn:hover {
            background: #fc8181;
            color: white;
            text-decoration: none;
        }

        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #64748b;
        }

        .empty-state i {
            font-size: 4rem;
            margin-bottom: 20px;
            color: #cbd5e0;
        }

        .empty-state h3 {
            font-size: 1.5rem;
            margin-bottom: 10px;
            color: #4a5568;
        }

        .empty-state p {
            font-size: 1.1rem;
            margin-bottom: 25px;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .container {
                padding: 15px;
            }

            .header h1 {
                font-size: 2rem;
            }

            .controls {
                flex-direction: column;
                align-items: stretch;
            }

            .search-filter {
                width: 100%;
            }

            .table-container {
                overflow-x: auto;
            }

            table {
                min-width: 600px;
            }

            .stats-container {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 480px) {
            .header {
                padding: 20px;
            }

            .header h1 {
                font-size: 1.8rem;
            }

            .stat-card {
                padding: 20px;
            }

            th, td {
                padding: 12px 16px;
            }

            .actions {
                flex-direction: column;
                gap: 5px;
            }

            .action-btn {
                font-size: 0.8rem;
                padding: 6px 10px;
            }
        }

        /* Animation for new elements */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .table-container {
            animation: fadeInUp 0.6s ease-out;
        }

        .stat-card {
            animation: fadeInUp 0.6s ease-out;
        }

        .header {
            animation: fadeInUp 0.4s ease-out;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="header">
        <h1><i class="fas fa-wallet"></i> Expense Tracker Pro</h1>
        <p class="subtitle">Manage your finances with style and precision</p>
    </div>

    <div class="stats-container">
        <div class="stat-card total-expense">
            <div class="icon">
                <i class="fas fa-dollar-sign"></i>
            </div>
            <h3>Total Expenses</h3>
            <div class="value">$<fmt:formatNumber value="${totalExpense != null ? totalExpense : 0}" type="number" minFractionDigits="2" maxFractionDigits="2" /></div>
        </div>
        <div class="stat-card expense-count">
            <div class="icon">
                <i class="fas fa-receipt"></i>
            </div>
            <h3>Total Records</h3>
            <div class="value">${expenses != null ? expenses.size() : 0}</div>
        </div>
    </div>

    <div class="controls">
        <div class="search-filter">
            <div class="search-box">
                <input type="text" id="searchInput" placeholder="Search expenses..." onkeyup="filterExpenses()">
                <i class="fas fa-search"></i>
            </div>
            <select class="filter-select" id="categoryFilter" onchange="filterExpenses()">
                <option value="">All Categories</option>
                <option value="Food">Food</option>
                <option value="Transport">Transport</option>
                <option value="Entertainment">Entertainment</option>
                <option value="Utilities">Utilities</option>
                <option value="Other">Other</option>
            </select>
        </div>
        <a href="${pageContext.request.contextPath}/expenses/new" class="add-expense-btn">
            <i class="fas fa-plus"></i>
            Add New Expense
        </a>
    </div>

    <div class="table-container">
        <c:choose>
            <c:when test="${expenses != null && expenses.size() > 0}">
                <table id="expenseTable">
                    <thead>
                    <tr>
                        <th><i class="fas fa-calendar-alt"></i> Date</th>
                        <th><i class="fas fa-tags"></i> Category</th>
                        <th><i class="fas fa-file-alt"></i> Description</th>
                        <th><i class="fas fa-dollar-sign"></i> Amount</th>
                        <th><i class="fas fa-cogs"></i> Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="expense" items="${expenses}">
                        <tr class="expense-row" data-category="${expense.category}" data-description="${expense.description}">
                            <td data-label="Date">
                                <i class="fas fa-calendar-alt" style="color: #64748b; margin-right: 8px;"></i>
                                    ${expense.date}
                            </td>
                            <td data-label="Category">
                                <span class="category-badge category-${expense.category.toLowerCase()}">${expense.category}</span>
                            </td>
                            <td data-label="Description">${expense.description}</td>
                            <td data-label="Amount" class="amount-cell">$${expense.amount}</td>
                            <td data-label="Actions" class="actions">
                                <a href="${pageContext.request.contextPath}/expenses/edit/${expense.id}" class="action-btn edit-btn">
                                    <i class="fas fa-edit"></i> Edit
                                </a>
                                <a href="${pageContext.request.contextPath}/expenses/delete/${expense.id}"
                                   class="action-btn delete-btn"
                                   onclick="return confirm('⚠️ Are you sure you want to delete this expense? This action cannot be undone.')">
                                    <i class="fas fa-trash-alt"></i> Delete
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <i class="fas fa-receipt"></i>
                    <h3>No Expenses Yet</h3>
                    <p>Start tracking your expenses by adding your first record!</p>
                    <a href="${pageContext.request.contextPath}/expenses/new" class="add-expense-btn">
                        <i class="fas fa-plus"></i>
                        Add Your First Expense
                    </a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<script>
    function filterExpenses() {
        const searchTerm = document.getElementById('searchInput').value.toLowerCase();
        const categoryFilter = document.getElementById('categoryFilter').value;
        const rows = document.querySelectorAll('.expense-row');

        rows.forEach(row => {
            const category = row.getAttribute('data-category');
            const description = row.getAttribute('data-description').toLowerCase();
            const amount = row.cells[3].textContent.toLowerCase();
            const date = row.cells[0].textContent.toLowerCase();

            const matchesSearch = description.includes(searchTerm) ||
                amount.includes(searchTerm) ||
                date.includes(searchTerm) ||
                category.toLowerCase().includes(searchTerm);

            const matchesCategory = categoryFilter === '' || category === categoryFilter;

            if (matchesSearch && matchesCategory) {
                row.style.display = '';
                row.style.animation = 'fadeInUp 0.3s ease-out';
            } else {
                row.style.display = 'none';
            }
        });

        // Update visible count
        const visibleRows = document.querySelectorAll('.expense-row[style=""], .expense-row:not([style])');
        const totalVisible = Array.from(visibleRows).filter(row => row.style.display !== 'none').length;

        // Update the count in stats if needed
        const countElement = document.querySelector('.expense-count .value');
        if (countElement) {
            countElement.textContent = totalVisible;
        }
    }

    // Add keyboard shortcuts
    document.addEventListener('keydown', function(e) {
        if (e.ctrlKey && e.key === 'n') {
            e.preventDefault();
            window.location.href = '${pageContext.request.contextPath}/expenses/new';
        }
        if (e.ctrlKey && e.key === 'f') {
            e.preventDefault();
            document.getElementById('searchInput').focus();
        }
    });

    // Initialize tooltips and enhanced interactions
    document.addEventListener('DOMContentLoaded', function() {
        // Add subtle hover effects to table rows
        const rows = document.querySelectorAll('tbody tr');
        rows.forEach(row => {
            row.addEventListener('mouseenter', function() {
                this.style.transform = 'scale(1.02)';
                this.style.boxShadow = '0 4px 12px rgba(0,0,0,0.1)';
            });

            row.addEventListener('mouseleave', function() {
                this.style.transform = 'scale(1)';
                this.style.boxShadow = 'none';
            });
        });

        // Add loading animation to action buttons
        const actionButtons = document.querySelectorAll('.action-btn');
        actionButtons.forEach(btn => {
            btn.addEventListener('click', function(e) {
                if (!this.classList.contains('delete-btn')) {
                    this.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Loading...';
                }
            });
        });
    });
</script>
</body>
</html>