package com.AW.DataBaseWeb.controller;

import com.AW.DataBaseWeb.model.Movie;
import com.AW.DataBaseWeb.repository.ActorDirectorRepository;
import com.AW.DataBaseWeb.repository.MovieRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class MovieController {

    @Autowired
    MovieRepository movieRepository;
    @Autowired
    ActorDirectorRepository actorDirectorRepository;

    @GetMapping("/movieList")
    public String mmovieList(Model model){
        model.addAttribute("MovieList",movieRepository.findAllNotHidden());
        return "Movie/MovieList";
    }
    @GetMapping("/movieList/remove/{id}")
    public String movieRemove(@PathVariable int id){
        Movie movie = movieRepository.getById(id);
        movie.setHidden(true);
        movieRepository.save(movie);
        return "redirect:/movieList";
    }
    @GetMapping("/movieAdd")
    public String movieAdd(Model model){
        model.addAttribute("Movie",new Movie());
        model.addAttribute("director",actorDirectorRepository.findAll());
        return "Movie/MovieAdd";
    }
    @PostMapping("/movieAdd")
    public String movieSave(Movie movie){
        movieRepository.save(movie);
        return "redirect:/movieList";
    }
}
