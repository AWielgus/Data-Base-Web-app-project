package com.AW.DataBaseWeb.controller;

import com.AW.DataBaseWeb.model.MovieActor;
import com.AW.DataBaseWeb.model.MovieTag;
import com.AW.DataBaseWeb.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class MAMTController {

    @Autowired
    MovieActorRepository movieActorRepository;
    @Autowired
    MovieTagRepository movieTagRepository;
    @Autowired
    TagRepository tagRepository;
    @Autowired
    MovieRepository movieRepository;
    @Autowired
    ActorDirectorRepository actorDirectorRepository;


    @GetMapping("/MAList")
    public String MAList(Model model){
        model.addAttribute("MAList",movieActorRepository.findAll());
        return "MAMT/MAList";
    }
    @GetMapping("/MAList/remove/{id}")
    public String MARemove(@PathVariable int id){
        movieActorRepository.delete(movieActorRepository.getById(id));
        return "redirect:/MAList";
    }
    @GetMapping("/MAAdd")
    public String MAAdd(Model model){
        model.addAttribute("MovieActor",new MovieActor());
        model.addAttribute("movies",movieRepository.findAllNotHidden());
        model.addAttribute("actors",actorDirectorRepository.findAllNotHidden());
        return "MAMT/MAAdd";
    }
    @PostMapping("/MAAdd")
    public String MASave(MovieActor movieActor){
        movieActorRepository.save(movieActor);
        return "redirect:/MAList";
    }

    @GetMapping("/MTList")
    public String MTList(Model model){
        model.addAttribute("MTList",movieTagRepository.findAll());
        return "MAMT/MTList";
    }
    @GetMapping("/MTList/remove/{id}")
    public String MTRemove(@PathVariable int id){
        movieTagRepository.delete(movieTagRepository.getById(id));
        return "redirect:/MTList";
    }
    @GetMapping("/MTAdd")
    public String MTAdd(Model model){
        model.addAttribute("MovieTag",new MovieTag());
        model.addAttribute("movies",movieRepository.findAllNotHidden());
        model.addAttribute("tags",tagRepository.findAllNotHidden());
        return "MAMT/MTAdd";
    }
    @PostMapping("/MTAdd")
    public String MTSave(MovieTag movieTag){
        movieTagRepository.save(movieTag);
        return "redirect:/MTList";
    }
}
