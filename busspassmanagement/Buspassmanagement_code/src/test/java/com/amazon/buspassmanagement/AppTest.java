package com.amazon.buspassmanagement;

import static org.junit.Assert.assertTrue;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.util.Base64;
import java.util.List;

import org.junit.Assert;
import org.junit.Test;

import com.amazon.buspassmanagement.controller.AuthenticationService;
import com.amazon.buspassmanagement.db.BusPassDAO;
import com.amazon.buspassmanagement.db.RouteDAO;
import com.amazon.buspassmanagement.model.BusPass;
import com.amazon.buspassmanagement.model.Route;
import com.amazon.buspassmanagement.model.User;

// Reference Link to Use JUnit as Testing Tool in your Project
// https://maven.apache.org/surefire/maven-surefire-plugin/examples/junit.html

public class AppTest {
    
	AuthenticationService authService = AuthenticationService.getInstance();
	
	// UNIT TESTS
	//Test auto login with incorrect credentials

	@Test
	public void testUserLogin() {
		
		User user = new User();
		user.email = "abc@example.com";
		//user.password = "sia123";
		user.password = "Passwordqwer";
		
		boolean result = authService.loginUser(user);
		
		// Assertion -> Either Test Cases Passes or It will Fail :)
		Assert.assertEquals(true, result);
		
	}

	//Test admin login with incorrect credentials

	@Test
	public void testAdminLogin() {
		
		User user = new User();
		user.email = "you@example.com";
		user.password = "Admin@123";
		
		boolean result = authService.loginUser(user);
		
		// Assertion -> Either Test Cases Passes or It will Fail :)
		Assert.assertEquals(true, result);
		Assert.assertEquals(1, user.type); // 1 should be equal to 1
		
	}

	//Unit test creating a route using admin login

	@Test
	public void testCreateRoute() {
		User user = new User();
		
		user.email = "admin@example.com";
		user.password = "12345";
		
		try {
			// Encoded to Hash i.e. SHA-256 so as to match correctly
			MessageDigest digest = MessageDigest.getInstance("SHA-256");
			byte[] hash = digest.digest(user.password.getBytes(StandardCharsets.UTF_8));
			user.password = Base64.getEncoder().encodeToString(hash);
			
		}catch (Exception e) {
			System.err.println("Something Went Wrong: "+e);
		}
		
		boolean result = authService.loginUser(user);
		
		// Assertion -> Either Test Cases Passes or It will Fail :)
		assertTrue(result);

		if(result && user.type == 1) {
			Route route = new Route();
			RouteDAO routeDAO = new RouteDAO();
			
			route.adminId = user.id;
			route.title = "BLR";
			route.description = "mas to blr";
			
			int result1 = routeDAO.insert(route);
			
			assertTrue(result1 > 0);
			
			String message = (result1 > 0) ? "Route Added Successfully" : "Adding Route Failed. Try Again.."; 
			System.out.println(message);
			
		}
	}

	//Unit test to succesfully apply for a pass using user login

	@Test
	public void testPassApply() {
		
		User user = new User();
		
		user.email = "abc@abc.com";
		user.password = "1234";
		
		try {
			// Encoded to Hash i.e. SHA-256 so as to match correctly
			MessageDigest digest = MessageDigest.getInstance("SHA-256");
			byte[] hash = digest.digest(user.password.getBytes(StandardCharsets.UTF_8));
			user.password = Base64.getEncoder().encodeToString(hash);
			
		}catch (Exception e) {
			System.err.println("Something Went Wrong: "+e);
		}
		
		boolean result = authService.loginUser(user);
		
		// Assertion -> Either Test Cases Passes or It will Fail :)
		assertTrue(result);
		
		if(result) {
			
			BusPass pass = new BusPass();
			BusPassDAO passDAO = new BusPassDAO();
			
			pass.routeId = 3;
			
			// Add the User ID Implicitly.
			pass.uid = user.id;
			
			// As initially record will be inserted by User where it is a request
			pass.status = 1; // initial status as requested :)
			
			int result1 = passDAO.insert(pass);
			
			assertTrue(result1 > 0);
			
			String message = (result1 > 0) ? "Pass Requested Successfully" : "Request for Pass Failed. Try Again.."; 
			
			System.out.println(message);
			
		}

	}

	//Unit test for successful user login and view routes

	@Test
	public void testviewroute() {
		
		User user = new User();
		
		user.email = "abc@abc.com";
		user.password = "1234";
		
		try {
			// Encoded to Hash i.e. SHA-256 so as to match correctly
			MessageDigest digest = MessageDigest.getInstance("SHA-256");
			byte[] hash = digest.digest(user.password.getBytes(StandardCharsets.UTF_8));
			user.password = Base64.getEncoder().encodeToString(hash);
			
		}catch (Exception e) {
			System.err.println("Something Went Wrong: "+e);
		}
		
		boolean result = authService.loginUser(user);
		
		// Assertion -> Either Test Cases Passes or It will Fail :)
		assertTrue(result);
		
		if(result) {
			
			BusPass pass = new BusPass();
			BusPassDAO passDAO = new BusPassDAO();
			RouteDAO routeDAO = new RouteDAO();
			
			List<Route> objects = routeDAO.retrieve();
			
			for(Route object : objects) {
				
				object.prettyPrint();
			}
			
		}

	}
	
}