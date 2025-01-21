package com.nodove.community.nodove.domain.users;

import static com.querydsl.core.types.PathMetadataFactory.*;

import com.querydsl.core.types.dsl.*;

import com.querydsl.core.types.PathMetadata;
import javax.annotation.processing.Generated;
import com.querydsl.core.types.Path;


/**
 * QUserStatus is a Querydsl query type for UserStatus
 */
@Generated("com.querydsl.codegen.DefaultEntitySerializer")
public class QUserStatus extends EntityPathBase<UserStatus> {

    private static final long serialVersionUID = -224215259L;

    public static final QUserStatus userStatus = new QUserStatus("userStatus");

    public final StringPath description = createString("description");

    public final NumberPath<Long> id = createNumber("id", Long.class);

    public final StringPath status = createString("status");

    public QUserStatus(String variable) {
        super(UserStatus.class, forVariable(variable));
    }

    public QUserStatus(Path<? extends UserStatus> path) {
        super(path.getType(), path.getMetadata());
    }

    public QUserStatus(PathMetadata metadata) {
        super(UserStatus.class, metadata);
    }

}

