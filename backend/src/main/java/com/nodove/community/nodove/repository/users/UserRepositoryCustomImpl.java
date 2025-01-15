package com.nodove.community.nodove.repository.users;

import com.nodove.community.nodove.domain.users.QUser;
import com.querydsl.jpa.impl.JPAQueryFactory;
import jakarta.persistence.EntityManager;
import org.springframework.stereotype.Repository;

@Repository
public class UserRepositoryCustomImpl implements UserRepositoryCustom{

    private final JPAQueryFactory jpaQueryFactory;

    public UserRepositoryCustomImpl(EntityManager entityManager) {
        this.jpaQueryFactory = new JPAQueryFactory(entityManager);
    }

    @Override
    public boolean updateEmailValidation(String email) {
        long updatedRows =  jpaQueryFactory.update(QUser.user)
                .where(QUser.user.email.eq(email))
                .set(QUser.user.isActive, true)
                .execute();
        return updatedRows > 0;
    }
}
