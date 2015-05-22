package com.iscream.controller;


import com.iscream.service.ComplainService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributesModelMap;

import javax.annotation.Resource;

@Controller
@RequestMapping("/complain")
@SessionAttributes({"currentUser", "currentId"})
public class ComplainController {

    @Resource
    private ComplainService complainService;

    @RequestMapping(method = RequestMethod.POST)
    public String create(@RequestParam String type, @RequestParam int complainId, @RequestParam String content, ModelMap model, RedirectAttributesModelMap redirectModel) {
        if (complainService.complain((Integer) model.get("currentId"), type, complainId, content)) {
        }else{
            redirectModel.addFlashAttribute("complainError", "has-error");
        }
        return "redirect:/" + type + "/" + complainId;
    }

    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    public String destroy(@RequestParam int id, ModelMap model, RedirectAttributesModelMap redirectModel) {
        if (complainService.delete(id)){
        }else{
            redirectModel.addAttribute("complainDeleteError", "has-error");
        }
        return "redirect:/admin";
    }
}
