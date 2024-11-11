package edu.sm.service;

import edu.sm.frame.SMService;
import edu.sm.model.Senior;
import edu.sm.repository.SeniorRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
public class SeniorService implements SMService<Integer, Senior> {

    private final SeniorRepository seniorRepository;

    @Override
    public void add(Senior senior) throws Exception {

    }

    @Override
    public void modify(Senior senior) throws Exception {

    }

    @Override
    public void del(Integer integer) throws Exception {

    }

    @Override
    public Senior get(Integer integer) throws Exception {
        return seniorRepository.selectOne(integer);
    }

    @Override
    public List<Senior> get() throws Exception {
        return seniorRepository.findAll();
    }

    @Override
    public void modifyById(Integer integer, Senior senior) throws Exception {
        SMService.super.modifyById(integer, senior);
    }
}
