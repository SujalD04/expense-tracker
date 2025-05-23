package com.example.project.controller;

import com.example.project.model.Expense;
import com.example.project.service.ExpenseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.*;

@Controller
@RequestMapping("/expenses")
public class ExpenseController {
    @Autowired
    private final ExpenseService expenseService;

    public ExpenseController(ExpenseService expenseService) {
        this.expenseService = expenseService;
    }

    @GetMapping
    public String listExpenses(Model model) {
        List<Expense> expenses = expenseService.getAllExpenses();
        Double totalExpense = expenseService.getTotalExpense();

        model.addAttribute("expenses", expenses);
        model.addAttribute("totalExpense", totalExpense != null ? totalExpense : 0.0);

        return "expense-list";  // Your JSP page
    }

    @GetMapping("/new")
    public String showNewExpenseForm(Model model) {
        Expense expense = new Expense();
        model.addAttribute("expense", expense);
        return "expense-form";
    }

    @PostMapping
    public String saveExpense(@ModelAttribute("expense") Expense expense) {
        expenseService.saveExpense(expense);
        return "redirect:/expenses";
    }

    @GetMapping("/edit/{id}")
    public String showEditExpenseForm(@PathVariable Long id, Model model) {
        Expense expense = expenseService.getExpenseById(id);
        model.addAttribute("expense", expense);
        return "expense-form";
    }

    @PostMapping("/{id}")
    public String updateExpense(@PathVariable Long id, @ModelAttribute("expense") Expense expense) {
        Expense existingExpense = expenseService.getExpenseById(id);

        existingExpense.setAmount(expense.getAmount());
        existingExpense.setCategory(expense.getCategory());
        existingExpense.setDescription(expense.getDescription());
        existingExpense.setDate(expense.getDate());

        expenseService.saveExpense(existingExpense);
        return "redirect:/expenses";
    }

    @GetMapping("/delete/{id}")
    public String deleteExpense(@PathVariable Long id) {
        Expense expense = expenseService.getExpenseById(id);
        expenseService.deleteExpense(expense);
        return "redirect:/expenses";
    }

}
