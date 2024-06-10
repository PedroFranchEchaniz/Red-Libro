package com.example.redlibro.user.dto;

import com.example.redlibro.booking.model.Booking;
import com.example.redlibro.user.model.Client;
import com.example.redlibro.user.model.UserModel;
import lombok.Builder;

import java.util.UUID;

@Builder
public record UserDto(
        UUID uuid,

        String username,

        boolean isEnable
) {

    public static UserDto of (UserModel userModel){
        return UserDto.builder()
                .uuid(userModel.getUuid())
                .username(userModel.getUsername())
                .isEnable(userModel.isEnabled())
                .build();
    }
}
