package com.example.redlibro.user.dto;

import com.example.redlibro.user.model.Shop;
import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.*;
import lombok.experimental.SuperBuilder;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
@JsonInclude(JsonInclude.Include.NON_NULL)
public class JwtShopResponse extends ShopResponse {

    private String token;
    private String refreshToken;

    public JwtShopResponse(ShopResponse shopResponse){
        id = shopResponse.getId();
        username = shopResponse.getUsername();
        name = shopResponse.getName();
        roles = shopResponse.getRoles();
    }

    public static JwtShopResponse of (Shop shop, String token){
        JwtShopResponse result = new JwtShopResponse(ShopResponse.fromShop(shop));
        result.setToken(token);
        return result;
    }
}
