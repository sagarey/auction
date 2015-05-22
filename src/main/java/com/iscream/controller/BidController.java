package com.iscream.controller;


import com.iscream.service.BidService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributesModelMap;

import javax.annotation.Resource;

@Controller
@RequestMapping("/bid")
@SessionAttributes({"currentUser", "currentId"})
public class BidController {

    @Resource
    private BidService bidService;

    @RequestMapping(method = RequestMethod.POST)
    public String create(@RequestParam int goodsId, @RequestParam int offer, ModelMap model, RedirectAttributesModelMap redirectModel) {
        if (bidService.bid((Integer) model.get("currentId"), goodsId, offer)) {
            return "redirect:/goods/" + goodsId;
        }else{
            redirectModel.addFlashAttribute("bidError", "has-error");
            return "redirect:/goods/" + goodsId;
        }
    }
}