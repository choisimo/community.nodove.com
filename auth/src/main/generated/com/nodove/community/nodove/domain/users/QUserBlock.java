package com.nodove.community.nodove.domain.users;

import static com.querydsl.core.types.PathMetadataFactory.*;

import com.querydsl.core.types.dsl.*;

import com.querydsl.core.types.PathMetadata;
import javax.annotation.processing.Generated;
import com.querydsl.core.types.Path;
import com.querydsl.core.types.dsl.PathInits;


/**
 * QUserBlock is a Querydsl query type for UserBlock
 */
@Generated("com.querydsl.codegen.DefaultEntitySerializer")
public class QUserBlock extends EntityPathBase<UserBlock> {

    private static final long serialVersionUID = -23158022L;

    private static final PathInits INITS = PathInits.DIRECT2;

    public static final QUserBlock userBlock = new QUserBlock("userBlock");

    public final DateTimePath<java.time.LocalDateTime> blockedAt = createDateTime("blockedAt", java.time.LocalDateTime.class);

    public final QUser blockedBy;

    public final NumberPath<Long> id = createNumber("id", Long.class);

    public final StringPath reason = createString("reason");

    public final DateTimePath<java.time.LocalDateTime> unblockedAt = createDateTime("unblockedAt", java.time.LocalDateTime.class);

    public final QUser user;

    public QUserBlock(String variable) {
        this(UserBlock.class, forVariable(variable), INITS);
    }

    public QUserBlock(Path<? extends UserBlock> path) {
        this(path.getType(), path.getMetadata(), PathInits.getFor(path.getMetadata(), INITS));
    }

    public QUserBlock(PathMetadata metadata) {
        this(metadata, PathInits.getFor(metadata, INITS));
    }

    public QUserBlock(PathMetadata metadata, PathInits inits) {
        this(UserBlock.class, metadata, inits);
    }

    public QUserBlock(Class<? extends UserBlock> type, PathMetadata metadata, PathInits inits) {
        super(type, metadata, inits);
        this.blockedBy = inits.isInitialized("blockedBy") ? new QUser(forProperty("blockedBy")) : null;
        this.user = inits.isInitialized("user") ? new QUser(forProperty("user")) : null;
    }

}

