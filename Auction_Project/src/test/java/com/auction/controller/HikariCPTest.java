package com.auction.controller;

import static org.junit.Assert.*;

import java.sql.Connection;
import javax.inject.Inject;
import javax.sql.DataSource;

import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
@Slf4j
public class HikariCPTest {

	
	@Autowired
	private DataSource ds;
	
	//@Inject
//	private SqlSessionFactory sf;
	
	@Test
	public void getDataSourceTest() {
		assertNotNull(ds);
	}
	
}
