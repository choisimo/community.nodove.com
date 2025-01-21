package com.nodove.community.nodove.domain.users;

import io.swagger.v3.oas.annotations.media.DependentSchema;
import io.swagger.v3.oas.annotations.media.SchemaProperties;
import io.swagger.v3.oas.annotations.media.SchemaProperty;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "user_status")
@DependentSchema(name = "UserStatus")
@SchemaProperties({
        @SchemaProperty(name = "UserStatus"),
        @SchemaProperty(name = "UserStatus.id"),
        @SchemaProperty(name = "UserStatus.status"),
        @SchemaProperty(name = "UserStatus.description")
})
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserStatus {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "status", nullable = false)
    private String status;                      // status by user custom

    @Column(name = "description", nullable = false)
    private String description;                 // description of the status by user  (as user message)
    
}
