package com.nodove.community.nodove.configuration.security.constructor;

import com.nodove.community.nodove.domain.users.User;
import com.nodove.community.nodove.domain.users.UserBlock;
import com.nodove.community.nodove.repository.users.UserBlockRepository;
import com.nodove.community.nodove.repository.users.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@RequiredArgsConstructor
public class PrincipalDetailsService implements UserDetailsService {

    private final UserRepository userRepository;
    private final UserBlockRepository userBlockRepository;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        // 1. User 조회
        User user = userRepository.findByEmail(username).orElseThrow(() -> new UsernameNotFoundException("해당 사용자를 찾을 수 없습니다."));

        // 2. UserBlock 조회
        UserBlock userBlock = userBlockRepository.findActiveBlockByUserId((user.getId())).orElse(null);

        // 3. principalDetails 생성
        return new PrincipalDetails(user, userBlock);
    }
}
