package com.example.redlibro.error.model.impl;

import com.example.redlibro.error.model.ApiError;
import com.example.redlibro.error.model.ApiSubError;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.http.HttpStatus;

import java.time.LocalDateTime;
import java.util.List;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonInclude;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ApiErrorImpl implements ApiError {
    private HttpStatus status;
    private String message;
    private String path;

    private int statusCode;

    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "dd/MM/yyyy HH:mm:ss")
    @Builder.Default
    private LocalDateTime date = LocalDateTime.now();

    @JsonInclude(JsonInclude.Include.NON_NULL)
    private List<ApiSubError> subErrors;

    public int getStatusCode() {
        return status != null ? status.value() : 0;
    }
}
