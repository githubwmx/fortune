package com.my.task;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.my.api.IArticleService;
import com.my.api.ILifeService;

@Component
public class MyTask {  
	
	@Autowired
	private ILifeService iLifeService;
	@Autowired
	private IArticleService iArticleService;
	
    @Scheduled(cron="0 0/1 * * * ?")    
    public void dealDel(){
    	iLifeService.deleteDel();
    	iArticleService.deleteDel();
    }
    
}
