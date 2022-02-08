package com.AW.DataBaseWeb.controller;

import com.AW.DataBaseWeb.repository.ActorDirectorRepository;
import com.AW.DataBaseWeb.repository.MovieRepository;
import com.AW.DataBaseWeb.repository.TagRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class MainController {

    @Autowired
    MovieRepository movieRepository;

    @Autowired
    ActorDirectorRepository actorDirectorRepository;

    @Autowired
    TagRepository tagRepository;

    @GetMapping("/")
    public String index(Model model){
        model.addAttribute("actorDirector",actorDirectorRepository.findAllNotHidden());
        model.addAttribute("tag",tagRepository.findAllNotHidden());
        model.addAttribute("movie",movieRepository.findAllNotHidden());
        return "home";
    }

//    procedures
    @PostMapping("/proc1")
    public String procedure1(@ModelAttribute("value") String value){
        movieRepository.procedure1(value);
        return "redirect:/";
    }
    @PostMapping("/proc2")
    public String procedure2(@ModelAttribute("firstname") String firstname,@ModelAttribute("lastname") String lastname){
        movieRepository.procedure2(firstname,lastname);
        return "redirect:/";
    }
    @PostMapping("/proc3")
    public String procedure3(){
        movieRepository.procedure3();
        return "redirect:/";
    }

    @PostMapping("/func1")
    public String function1(Model model, @ModelAttribute("value") int value){
        String[] temp = movieRepository.func1(value).split(",");
        if (temp.length == 2){
            model.addAttribute("movie",movieRepository.getById(Integer.valueOf(temp[0])));
            model.addAttribute("avg",temp[1]);
        }else{
            model.addAttribute("movie","brak");
            model.addAttribute("avg","brak");
        }
        return "FunctionProcedure/func1";
    }
    @PostMapping("/func2")
    public String function2(Model model, @ModelAttribute("value") int value){
        model.addAttribute("list",movieRepository.func2(value));
        return "FunctionProcedure/func2";
    }
    @PostMapping("/func3")
    public String function3(Model model, @ModelAttribute("value") int value){
        String[] temp = movieRepository.func3(value).split(",");
        if (temp.length == 2){
            model.addAttribute("movie",movieRepository.getById(Integer.valueOf(temp[0])));
        }else{
            model.addAttribute("movie","brak");
        }
        return "FunctionProcedure/func3";

    }

}
