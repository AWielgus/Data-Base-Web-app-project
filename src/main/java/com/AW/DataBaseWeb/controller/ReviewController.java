package com.AW.DataBaseWeb.controller;

import com.AW.DataBaseWeb.model.Review;
import com.AW.DataBaseWeb.repository.MovieRepository;
import com.AW.DataBaseWeb.repository.ReviewRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import java.time.LocalDate;

@Controller
public class ReviewController {

    @Autowired
    ReviewRepository reviewRepository;
    @Autowired
    MovieRepository movieRepository;


    @GetMapping("/reviewList")
    public String reviewList(Model model){
        model.addAttribute("ReviewList",reviewRepository.findAllNotHidden());
        return "Review/ReviewList";
    }
    @GetMapping("/reviewList/remove/{id}")
    public String reviewRemove(@PathVariable int id){
        Review review = reviewRepository.getById(id);
        review.setHidden(true);
        reviewRepository.save(review);
        return "redirect:/reviewList";
    }
    @GetMapping("/reviewAdd")
    public String reviewAdd(Model model){
        model.addAttribute("Review",new Review());
        model.addAttribute("movie",movieRepository.findAllNotHidden());
        return "Review/ReviewAdd";
    }
    @PostMapping("/reviewAdd")
    public String movieSave(Review review){
        review.setDate(LocalDate.now());
        reviewRepository.save(review);
        return "redirect:/reviewList";
    }
}
