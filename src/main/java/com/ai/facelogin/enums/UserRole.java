package com.ai.facelogin.enums;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum UserRole {

    USER("USER","일반");

    private final String roleName;
    private final String korRoleName;
}
