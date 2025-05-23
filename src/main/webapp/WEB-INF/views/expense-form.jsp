<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>
        <c:choose>
            <c:when test="${expense.id == null}">Add New Expense - Expense Tracker Pro</c:when>
            <c:otherwise>Edit Expense - Expense Tracker Pro</c:otherwise>
        </c:choose>
    </title>
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
            padding: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #2d3748;
        }

        .form-wrapper {
            width: 100%;
            max-width: 600px;
            animation: slideInUp 0.8s ease-out;
        }

        @keyframes slideInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .form-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .form-header h1 {
            color: white;
            font-size: 2.5rem;
            font-weight: 800;
            margin-bottom: 8px;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .form-header .subtitle {
            color: rgba(255, 255, 255, 0.9);
            font-size: 1.1rem;
            font-weight: 500;
        }

        .form-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 24px;
            padding: 40px;
            box-shadow: 0 25px 50px rgba(0, 0, 0, 0.15);
            border: 1px solid rgba(255, 255, 255, 0.2);
            position: relative;
            overflow: hidden;
        }

        .form-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, #667eea, #764ba2, #667eea);
            background-size: 200% 100%;
            animation: gradientShift 3s ease-in-out infinite;
        }

        @keyframes gradientShift {
            0%, 100% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
        }

        .form-title {
            text-align: center;
            margin-bottom: 35px;
        }

        .form-title h2 {
            font-size: 1.8rem;
            font-weight: 700;
            color: #2d3748;
            margin-bottom: 8px;
        }

        .form-title p {
            color: #64748b;
            font-size: 1rem;
        }

        .form-group {
            margin-bottom: 25px;
            position: relative;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #374151;
            font-size: 0.95rem;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .form-group label i {
            color: #667eea;
            width: 16px;
        }

        .form-control {
            width: 100%;
            padding: 14px 16px;
            border: 2px solid #e5e7eb;
            border-radius: 12px;
            font-size: 1rem;
            background: #ffffff;
            transition: all 0.3s ease;
            position: relative;
        }

        .form-control:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.1);
            transform: translateY(-1px);
        }

        .form-control:hover {
            border-color: #d1d5db;
        }

        .form-control::placeholder {
            color: #9ca3af;
        }

        select.form-control {
            cursor: pointer;
            background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 20 20'%3e%3cpath stroke='%236b7280' stroke-linecap='round' stroke-linejoin='round' stroke-width='1.5' d='m6 8 4 4 4-4'/%3e%3c/svg%3e");
            background-position: right 12px center;
            background-repeat: no-repeat;
            background-size: 16px;
            padding-right: 40px;
            appearance: none;
        }

        .amount-input-wrapper {
            position: relative;
        }

        .currency-symbol {
            position: absolute;
            left: 16px;
            top: 50%;
            transform: translateY(-50%);
            color: #667eea;
            font-weight: 600;
            z-index: 1;
        }

        .amount-input {
            padding-left: 40px;
        }

        .category-options {
            display: none;
            grid-template-columns: repeat(auto-fit, minmax(120px, 1fr));
            gap: 12px;
            margin-top: 12px;
        }

        .category-option {
            padding: 12px;
            border: 2px solid #e5e7eb;
            border-radius: 8px;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s ease;
            background: #f9fafb;
        }

        .category-option:hover {
            border-color: #667eea;
            background: #f0f4ff;
        }

        .category-option.selected {
            border-color: #667eea;
            background: #667eea;
            color: white;
        }

        .form-actions {
            display: flex;
            gap: 16px;
            margin-top: 35px;
        }

        .btn {
            flex: 1;
            padding: 14px 24px;
            border: none;
            border-radius: 12px;
            font-weight: 600;
            font-size: 1rem;
            cursor: pointer;
            text-decoration: none;
            text-align: center;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            position: relative;
            overflow: hidden;
        }

        .btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: left 0.5s;
        }

        .btn:hover::before {
            left: 100%;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);
        }

        .btn-secondary {
            background: #f8fafc;
            color: #475569;
            border: 2px solid #e2e8f0;
        }

        .btn-secondary:hover {
            background: #e2e8f0;
            color: #334155;
            text-decoration: none;
        }

        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            margin-top: 25px;
            color: rgba(255, 255, 255, 0.9);
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
            justify-content: center;
        }

        .back-link:hover {
            color: white;
            transform: translateX(-4px);
        }

        .quick-amounts {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 8px;
            margin-top: 12px;
        }

        .quick-amount {
            padding: 8px 12px;
            background: #f1f5f9;
            border: 1px solid #e2e8f0;
            border-radius: 6px;
            text-align: center;
            cursor: pointer;
            font-size: 0.85rem;
            font-weight: 500;
            color: #475569;
            transition: all 0.3s ease;
        }

        .quick-amount:hover {
            background: #667eea;
            color: white;
            border-color: #667eea;
        }

        .form-help {
            font-size: 0.85rem;
            color: #6b7280;
            margin-top: 6px;
            display: flex;
            align-items: center;
            gap: 4px;
        }

        .validation-message {
            position: absolute;
            bottom: -20px;
            left: 0;
            font-size: 0.8rem;
            color: #ef4444;
            display: none;
        }

        .form-group.error .form-control {
            border-color: #ef4444;
            box-shadow: 0 0 0 4px rgba(239, 68, 68, 0.1);
        }

        .form-group.error .validation-message {
            display: block;
        }

        .loading-spinner {
            display: none;
            width: 20px;
            height: 20px;
            border: 2px solid transparent;
            border-top: 2px solid currentColor;
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            body {
                padding: 15px;
            }

            .form-container {
                padding: 30px 25px;
            }

            .form-header h1 {
                font-size: 2rem;
            }

            .form-actions {
                flex-direction: column;
            }

            .quick-amounts {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 480px) {
            .form-container {
                padding: 25px 20px;
                border-radius: 16px;
            }

            .form-header h1 {
                font-size: 1.8rem;
            }

            .form-title h2 {
                font-size: 1.5rem;
            }
        }

        /* Dark mode support */
        @media (prefers-color-scheme: dark) {
            .form-control {
                background: #1f2937;
                border-color: #374151;
                color: #f9fafb;
            }

            .form-control:focus {
                border-color: #667eea;
            }
        }
    </style>
</head>
<body>
<div class="form-wrapper">
    <div class="form-header">
        <h1>
            <i class="fas fa-wallet"></i>
            <c:choose>
                <c:when test="${expense.id == null}">Add Expense</c:when>
                <c:otherwise>Edit Expense</c:otherwise>
            </c:choose>
        </h1>
        <p class="subtitle">
            <c:choose>
                <c:when test="${expense.id == null}">Track your spending with ease</c:when>
                <c:otherwise>Update your expense details</c:otherwise>
            </c:choose>
        </p>
    </div>

    <div class="form-container">
        <div class="form-title">
            <h2>
                <c:choose>
                    <c:when test="${expense.id == null}">New Expense Record</c:when>
                    <c:otherwise>Expense Details</c:otherwise>
                </c:choose>
            </h2>
            <p>
                <c:choose>
                    <c:when test="${expense.id == null}">Fill in the details below to add a new expense</c:when>
                    <c:otherwise>Modify the information below to update this expense</c:otherwise>
                </c:choose>
            </p>
        </div>

        <form action="<c:choose>
                        <c:when test='${expense.id == null}'>${pageContext.request.contextPath}/expenses</c:when>
                        <c:otherwise>${pageContext.request.contextPath}/expenses/${expense.id}</c:otherwise>
                      </c:choose>" method="post" id="expenseForm" novalidate>

            <div class="form-group">
                <label for="date">
                    <i class="fas fa-calendar-alt"></i>
                    Date
                </label>
                <input type="date" id="date" name="date" value="${expense.date}" class="form-control" required/>
                <div class="form-help">
                    <i class="fas fa-info-circle"></i>
                    Select the date when this expense occurred
                </div>
                <div class="validation-message">Please select a valid date</div>
            </div>

            <div class="form-group">
                <label for="category">
                    <i class="fas fa-tags"></i>
                    Category
                </label>
                <select id="category" name="category" class="form-control" required>
                    <option value="" disabled ${empty expense.category ? 'selected' : ''}>Choose expense category</option>
                    <option value="Food" ${expense.category == 'Food' ? 'selected' : ''}>🍔 Food & Dining</option>
                    <option value="Transport" ${expense.category == 'Transport' ? 'selected' : ''}>🚗 Transportation</option>
                    <option value="Utilities" ${expense.category == 'Utilities' ? 'selected' : ''}>⚡ Utilities & Bills</option>
                    <option value="Entertainment" ${expense.category == 'Entertainment' ? 'selected' : ''}>🎬 Entertainment</option>
                    <option value="Other" ${expense.category == 'Other' ? 'selected' : ''}>📦 Other</option>
                </select>
                <div class="form-help">
                    <i class="fas fa-info-circle"></i>
                    Categorize your expense for better tracking
                </div>
                <div class="validation-message">Please select a category</div>
            </div>

            <div class="form-group">
                <label for="description">
                    <i class="fas fa-file-alt"></i>
                    Description
                    <span style="color: #9ca3af; font-weight: 400;">(Optional)</span>
                </label>
                <input type="text"
                       id="description"
                       name="description"
                       value="${expense.description}"
                       class="form-control"
                       placeholder="e.g., Coffee with team, Uber ride home, Netflix subscription"
                       maxlength="100"/>
                <div class="form-help">
                    <i class="fas fa-info-circle"></i>
                    Add more details about this expense (optional)
                </div>
            </div>

            <div class="form-group">
                <label for="amount">
                    <i class="fas fa-dollar-sign"></i>
                    Amount
                </label>
                <div class="amount-input-wrapper">
                    <span class="currency-symbol">$</span>
                    <input type="number"
                           id="amount"
                           step="0.01"
                           min="0"
                           name="amount"
                           value="${expense.amount}"
                           class="form-control amount-input"
                           placeholder="0.00"
                           required/>
                </div>
                <div class="quick-amounts">
                    <div class="quick-amount" onclick="setAmount(5.00)">$5</div>
                    <div class="quick-amount" onclick="setAmount(10.00)">$10</div>
                    <div class="quick-amount" onclick="setAmount(25.00)">$25</div>
                    <div class="quick-amount" onclick="setAmount(50.00)">$50</div>
                </div>
                <div class="form-help">
                    <i class="fas fa-info-circle"></i>
                    Enter the amount in dollars (click quick amounts above for common values)
                </div>
                <div class="validation-message">Please enter a valid amount greater than 0</div>
            </div>

            <div class="form-actions">
                <button type="submit" class="btn btn-primary" id="submitBtn">
                    <i class="fas fa-save"></i>
                    <span class="btn-text">
                        <c:choose>
                            <c:when test="${expense.id == null}">Save Expense</c:when>
                            <c:otherwise>Update Expense</c:otherwise>
                        </c:choose>
                    </span>
                    <div class="loading-spinner"></div>
                </button>
                <a href="${pageContext.request.contextPath}/expenses" class="btn btn-secondary">
                    <i class="fas fa-times"></i>
                    Cancel
                </a>
            </div>
        </form>

        <a href="${pageContext.request.contextPath}/expenses" class="back-link">
            <i class="fas fa-arrow-left"></i>
            Back to Expense List
        </a>
    </div>
</div>

<script>
    // Form validation and enhancement
    document.addEventListener('DOMContentLoaded', function() {
        const form = document.getElementById('expenseForm');
        const submitBtn = document.getElementById('submitBtn');
        const btnText = submitBtn.querySelector('.btn-text');
        const spinner = submitBtn.querySelector('.loading-spinner');

        // Set default date to today if creating new expense
        const dateInput = document.getElementById('date');
        if (!dateInput.value && ${expense.id == null}) {
            const today = new Date().toISOString().split('T')[0];
            dateInput.value = today;
        }

        // Form validation
        function validateField(field, errorMessage) {
            const formGroup = field.closest('.form-group');
            const validationMessage = formGroup.querySelector('.validation-message');

            if (!field.checkValidity() || (field.type === 'number' && parseFloat(field.value) <= 0)) {
                formGroup.classList.add('error');
                if (validationMessage) {
                    validationMessage.textContent = errorMessage || 'This field is required';
                }
                return false;
            } else {
                formGroup.classList.remove('error');
                return true;
            }
        }

        // Real-time validation
        const requiredFields = form.querySelectorAll('[required]');
        requiredFields.forEach(field => {
            field.addEventListener('blur', function() {
                let errorMessage = 'This field is required';

                if (field.type === 'date') {
                    errorMessage = 'Please select a valid date';
                } else if (field.type === 'number') {
                    errorMessage = 'Please enter a valid amount greater than 0';
                } else if (field.tagName === 'SELECT') {
                    errorMessage = 'Please select a category';
                }

                validateField(field, errorMessage);
            });

            field.addEventListener('input', function() {
                const formGroup = field.closest('.form-group');
                if (formGroup.classList.contains('error')) {
                    formGroup.classList.remove('error');
                }
            });
        });

        // Form submission
        form.addEventListener('submit', function(e) {
            e.preventDefault();

            let isValid = true;

            // Validate all required fields
            isValid &= validateField(document.getElementById('date'), 'Please select a valid date');
            isValid &= validateField(document.getElementById('category'), 'Please select a category');
            isValid &= validateField(document.getElementById('amount'), 'Please enter a valid amount greater than 0');

            if (isValid) {
                // Show loading state
                submitBtn.disabled = true;
                btnText.style.display = 'none';
                spinner.style.display = 'inline-block';

                // Submit form
                setTimeout(() => {
                    form.submit();
                }, 500);
            } else {
                // Scroll to first error
                const firstError = form.querySelector('.form-group.error');
                if (firstError) {
                    firstError.scrollIntoView({ behavior: 'smooth', block: 'center' });
                }
            }
        });

        // Auto-format amount input
        const amountInput = document.getElementById('amount');
        amountInput.addEventListener('input', function() {
            // Remove non-numeric characters except decimal point
            this.value = this.value.replace(/[^0-9.]/g, '');

            // Ensure only one decimal point
            const parts = this.value.split('.');
            if (parts.length > 2) {
                this.value = parts[0] + '.' + parts.slice(1).join('');
            }

            // Limit to 2 decimal places
            if (parts[1] && parts[1].length > 2) {
                this.value = parseFloat(this.value).toFixed(2);
            }
        });

        // Category selection enhancement
        const categorySelect = document.getElementById('category');
        categorySelect.addEventListener('change', function() {
            // Add visual feedback for category selection
            this.style.background = this.value ? '#f0f4ff' : '#ffffff';
        });

        // Auto-save draft functionality (using session storage simulation)
        function saveDraft() {
            const formData = {
                date: document.getElementById('date').value,
                category: document.getElementById('category').value,
                description: document.getElementById('description').value,
                amount: document.getElementById('amount').value
            };

            // In a real application, you might want to implement auto-save
            console.log('Draft saved:', formData);
        }

        // Save draft every 30 seconds
        if (${expense.id == null}) {
            setInterval(saveDraft, 30000);
        }

        // Keyboard shortcuts
        document.addEventListener('keydown', function(e) {
            if (e.ctrlKey && e.key === 's') {
                e.preventDefault();
                form.dispatchEvent(new Event('submit'));
            }
            if (e.key === 'Escape') {
                window.location.href = '${pageContext.request.contextPath}/expenses';
            }
        });
    });

    // Quick amount setter
    function setAmount(amount) {
        const amountInput = document.getElementById('amount');
        amountInput.value = amount.toFixed(2);
        amountInput.focus();

        // Remove error state if present
        const formGroup = amountInput.closest('.form-group');
        formGroup.classList.remove('error');

        // Visual feedback
        const clickedButton = event.target;
        clickedButton.style.transform = 'scale(0.95)';
        setTimeout(() => {
            clickedButton.style.transform = 'scale(1)';
        }, 150);
    }

    // Enhanced focus management
    document.addEventListener('DOMContentLoaded', function() {
        // Focus first empty required field
        const firstEmptyField = document.querySelector('input[required]:not([value]), select[required]:not([value])');
        if (firstEmptyField) {
            setTimeout(() => firstEmptyField.focus(), 100);
        }
    });
</script>
</body>
</html>