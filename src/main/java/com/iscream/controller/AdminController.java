package com.iscream.controller;

import com.iscream.service.ComplainService;
import com.iscream.service.GoodsService;
import com.iscream.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;

import javax.annotation.Resource;

@Controller
@RequestMapping("/admin")
@SessionAttributes({"currentUser", "currentId"})
public class AdminController {

    @Resource
    private GoodsService goodsService;

    @Resource
    private UserService userService;

    @Resource
    private ComplainService complainService;

    @RequestMapping(method = RequestMethod.GET)
    public String admin(ModelMap model) {
        model.addAttribute("goodsinfoList", goodsService.all("check"));
        model.addAttribute("complaininfoList", complainService.all());
        model.addAttribute("frozenGoodsinfoList", goodsService.all("frozen"));
        model.addAttribute("frozenUserList", userService.all("frozen"));
        return "admin";
    }
}
