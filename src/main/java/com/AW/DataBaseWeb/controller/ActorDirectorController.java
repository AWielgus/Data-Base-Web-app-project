package com.AW.DataBaseWeb.controller;

import com.AW.DataBaseWeb.model.ActorDirector;
import com.AW.DataBaseWeb.repository.ActorDirectorRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class ActorDirectorController {

    @Autowired
    ActorDirectorRepository actorDirectorRepository;


    @GetMapping("/actorList")
    public String actorDirectorList(Model model){
        model.addAttribute("ActorList",actorDirectorRepository.findAllNotHidden());
        return "ActorDirector/ActorDirectorList";
    }
    @GetMapping("/ActorList/remove/{id}")
    public String actorDirectorRemove(@PathVariable int id){
        ActorDirector actorDirector = actorDirectorRepository.getById(id);
        actorDirector.setHidden(true);
        actorDirectorRepository.save(actorDirector);
        return "redirect:/actorList";
    }
    @GetMapping("/actorAdd")
    public String actorDirectorAdd(Model model){
        model.addAttribute("Actor",new ActorDirector());
        return "ActorDirector/ActorDirectorAdd";
    }
    @PostMapping("/actorAdd")
    public String actorDirectorSave(ActorDirector actorDirector){
        actorDirectorRepository.save(actorDirector);
        return "redirect:/actorList";
    }
}
