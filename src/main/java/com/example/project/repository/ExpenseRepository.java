package com.example.project.repository;

import com.example.project.model.Expense;
import org.hibernate.query.Page;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.awt.print.Pageable;

public interface ExpenseRepository extends JpaRepository<Expense, Long> {
    @Query("SELECT sum(e.amount) FROM Expense e")
    Double getTotalExpense();

}
