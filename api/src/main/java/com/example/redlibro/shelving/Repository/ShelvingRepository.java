package com.example.redlibro.shelving.Repository;

import com.example.redlibro.shelving.Shelving;
import com.example.redlibro.shelving.ShelvingPk;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ShelvingRepository extends JpaRepository<Shelving, ShelvingPk> {
}
