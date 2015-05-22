package com.iscream.controller;

import com.iscream.service.CommentService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributesModelMap;

import javax.annotation.Resource;

@Controller
@RequestMapping("/comment")
@SessionAttributes({"currentUser", "currentId"})
public class CommentController {

    @Resource
    private CommentService commentService;

    @RequestMapping(method = RequestMethod.POST)
    public String create(@RequestParam int goodsId, @RequestParam String content, ModelMap model, RedirectAttributesModelMap redirectModel) {
        if (commentService.comment((Integer) model.get("currentId"), goodsId, content)) {
        }else{
            redirectModel.addFlashAttribute("commentError", "has-error");
        }
        return "redirect:/goods/" + goodsId;
    }
}
