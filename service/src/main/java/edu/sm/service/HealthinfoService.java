package edu.sm.service;

import edu.sm.frame.SMService;
import edu.sm.model.HealthInfo;
import edu.sm.model.User;

import edu.sm.repository.HealthinfoRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import org.springframework.stereotype.Service;

import java.util.List;


@Slf4j
@Service
@RequiredArgsConstructor
public class HealthinfoService implements SMService<Integer, User> {
    private final HealthinfoRepository healthinfoRepository;

    @Override
    public void add(User user) throws Exception {

    }

    @Override
    public void modify(User user) throws Exception {

    }

    @Override
    public void del(Integer integer) throws Exception {

    }

    @Override
    public User get(Integer integer) throws Exception {
        return null;
    }

    @Override
    public List<User> get() throws Exception {
        return List.of();
    }

    public List<HealthInfo> getHealthInfoBySeniorId(Integer seniorId) throws Exception {
        if (seniorId == null || seniorId <= 0) {
            throw new IllegalArgumentException("Invalid senior ID: " + seniorId);
        }
        List<HealthInfo> healthInfoList = healthinfoRepository.findHealthInfoBySeniorId(seniorId);
        if (healthInfoList.isEmpty()) {
            log.info(seniorId +"번 시니어의 건강정보가 없습니다.");
        }
        return healthInfoList;
    }
}
