package com.iscream.controller;

import com.iscream.service.AnnouncementService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributesModelMap;

import javax.annotation.Resource;

@Controller
@RequestMapping("/announcement")
public class AnnouncementController {

    @Resource
    private AnnouncementService announcementService;

    @RequestMapping(method = RequestMethod.GET)
    public String index(ModelMap model) {
        model.addAttribute("announcementList", announcementService.getAll());
        return "announcement";
    }

    @RequestMapping(method = RequestMethod.POST)
    public String create(@RequestParam String title, @RequestParam String content, ModelMap model, RedirectAttributesModelMap redirectModel) {
        if (announcementService.announcement(title ,content)){
        }else{
            redirectModel.addAttribute("announcementError", "has-error");
        }
        return "redirect:/announcement";
    }

    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    public String destroy(@RequestParam int id, ModelMap model, RedirectAttributesModelMap redirectModel) {
        if (announcementService.delete(id)){
        }else{
            redirectModel.addAttribute("announcementDeleteError", "has-error");
        }
        return "redirect:/announcement";
    }
}
