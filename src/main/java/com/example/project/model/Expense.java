package com.example.project.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.id.factory.internal.AutoGenerationTypeStrategy;

import java.time.LocalDate;

@Setter
@Getter
@Entity
public class Expense {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String description;
    private Double amount;
    private String category;
    private LocalDate date;

    @Override
    public String toString() {
        return "Expense{" +
                "amount=" + amount +
                ", id=" + id +
                ", description='" + description + '\'' +
                ", category='" + category + '\'' +
                ", date=" + date +
                '}';
    }
}
