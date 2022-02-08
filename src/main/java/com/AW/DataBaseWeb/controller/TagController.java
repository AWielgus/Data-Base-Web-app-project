package com.AW.DataBaseWeb.controller;

import com.AW.DataBaseWeb.model.Tag;
import com.AW.DataBaseWeb.repository.TagRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class TagController {

    @Autowired
    TagRepository tagRepository;


    @GetMapping("/tagList")
    public String tagList(Model model){
        model.addAttribute("TagList",tagRepository.findAllNotHidden());
        return "Tag/TagList";
    }
    @GetMapping("/tagList/remove/{id}")
    public String tagRemove(@PathVariable int id){
        Tag tag = tagRepository.getById(id);
        tag.setHidden(true);
        tagRepository.save(tag);
        return "redirect:/tagList";
    }
    @GetMapping("/tagAdd")
    public String tagAdd(Model model){
        model.addAttribute("Tag",new Tag());
        return "Tag/TagAdd";
    }
    @PostMapping("/tagAdd")
    public String tagSave(Tag tag){
        tagRepository.save(tag);
        return "redirect:/tagList";
    }
}
