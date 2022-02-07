package com.AW.DataBaseWeb.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class MainController {

    @GetMapping("/")
    public String index(){
        return "home";
    }

//    procedures
    @PostMapping("/proc1")
    public String test(@ModelAttribute("value") String value){
        System.out.println(value);
        return "redirect:/";
    }

}
