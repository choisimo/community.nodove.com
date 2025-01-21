package com.nodove.community.nodove.repository.users;

import com.nodove.community.nodove.domain.users.QUser;
import com.nodove.community.nodove.domain.users.User;
import com.querydsl.jpa.impl.JPAQueryFactory;
import jakarta.persistence.EntityManager;
import jakarta.transaction.Transactional;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class UserRepositoryCustomImpl implements UserRepositoryCustom{

    private final JPAQueryFactory jpaQueryFactory;

    public UserRepositoryCustomImpl(EntityManager entityManager) {
        this.jpaQueryFactory = new JPAQueryFactory(entityManager);
    }

    @Transactional
    @Override
    public boolean updateEmailValidation(String email) {
        long updatedRows =  jpaQueryFactory.update(QUser.user)
                .where(QUser.user.email.eq(email))
                .set(QUser.user.isActive, true)
                .execute();
        return updatedRows > 0;
    }

    @Transactional
    @Override
    public List<User> ifEmailExistsAndActiveIsFalse(String email) {
        return jpaQueryFactory.select(QUser.user)
                .from(QUser.user)
                .where(QUser.user.email.eq(email).and(QUser.user.isActive.eq(false)))
                .fetch();
    }
}
