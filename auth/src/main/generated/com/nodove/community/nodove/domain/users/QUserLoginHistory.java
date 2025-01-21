package com.nodove.community.nodove.domain.users;

import static com.querydsl.core.types.PathMetadataFactory.*;

import com.querydsl.core.types.dsl.*;

import com.querydsl.core.types.PathMetadata;
import javax.annotation.processing.Generated;
import com.querydsl.core.types.Path;
import com.querydsl.core.types.dsl.PathInits;


/**
 * QUserLoginHistory is a Querydsl query type for UserLoginHistory
 */
@Generated("com.querydsl.codegen.DefaultEntitySerializer")
public class QUserLoginHistory extends EntityPathBase<UserLoginHistory> {

    private static final long serialVersionUID = -1728671266L;

    private static final PathInits INITS = PathInits.DIRECT2;

    public static final QUserLoginHistory userLoginHistory = new QUserLoginHistory("userLoginHistory");

    public final StringPath device = createString("device");

    public final NumberPath<Long> id = createNumber("id", Long.class);

    public final StringPath ipAddress = createString("ipAddress");

    public final BooleanPath isSuccess = createBoolean("isSuccess");

    public final DateTimePath<java.time.LocalDateTime> loginTime = createDateTime("loginTime", java.time.LocalDateTime.class);

    public final QUser user;

    public QUserLoginHistory(String variable) {
        this(UserLoginHistory.class, forVariable(variable), INITS);
    }

    public QUserLoginHistory(Path<? extends UserLoginHistory> path) {
        this(path.getType(), path.getMetadata(), PathInits.getFor(path.getMetadata(), INITS));
    }

    public QUserLoginHistory(PathMetadata metadata) {
        this(metadata, PathInits.getFor(metadata, INITS));
    }

    public QUserLoginHistory(PathMetadata metadata, PathInits inits) {
        this(UserLoginHistory.class, metadata, inits);
    }

    public QUserLoginHistory(Class<? extends UserLoginHistory> type, PathMetadata metadata, PathInits inits) {
        super(type, metadata, inits);
        this.user = inits.isInitialized("user") ? new QUser(forProperty("user")) : null;
    }

}

