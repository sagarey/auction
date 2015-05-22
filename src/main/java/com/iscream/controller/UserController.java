package com.iscream.controller;

import com.iscream.service.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.mvc.support.RedirectAttributesModelMap;

import javax.annotation.Resource;
import java.sql.Timestamp;
import java.util.Date;

@Controller
@RequestMapping("/")
@SessionAttributes({"currentUser", "currentId"})
public class UserController {

    @Resource
    private UserService userService;

    @Resource
    private GoodsService goodsService;

    @Resource
    private BidService bidService;

    @Resource
    private CommentService commentService;

    @Resource
    private ComplainService complainService;

    @RequestMapping(method = RequestMethod.GET)
    public String index(@RequestParam(defaultValue = "") String keyword, ModelMap model) {
        model.addAttribute("goodsinfoList", goodsService.search(keyword));
        model.addAttribute("keyword", keyword);
        return "index";
    }

    @RequestMapping(value = "/user/{id}", method = RequestMethod.GET)
    public String show(@PathVariable("id") int id, ModelMap model) {
        model.addAttribute("goodsinfoList", goodsService.allByUserId(id));
        model.addAttribute("user", userService.get(id));
        return "user";
    }

    @RequestMapping(value = "/index", method = RequestMethod.GET)
    public String indexIndex(ModelMap model) {
        return "redirect:/";
    }

    @RequestMapping(value = "/signup", method = RequestMethod.POST)
    public String signup(@RequestParam String name,@RequestParam String email,@RequestParam String password,@RequestParam String repassword, ModelMap model, RedirectAttributesModelMap redirectModel) {
        if (userService.signup(name, email, password, repassword)){
            model.addAttribute("currentUser", name);
            model.addAttribute("currentId", userService.getId(name));
        }else{
            redirectModel.addFlashAttribute("tab", "signup");
            redirectModel.addFlashAttribute("signupError", "has-error");
        }
        return "redirect:/";
    }

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public String login(@RequestParam String name, @RequestParam String password, ModelMap model, RedirectAttributesModelMap redirectModel) {
        if (userService.login(name, password)){
            model.addAttribute("currentUser", name);
            model.addAttribute("currentId", userService.getId(name));
            if (name.equals("admin")) {
                return "redirect:/admin";
            }
        }else{
            redirectModel.addFlashAttribute("loginError", "has-error");
        }
        return "redirect:/";
    }

    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public String logout(ModelMap model, SessionStatus sessionStatus) {
        sessionStatus.setComplete();
        return "redirect:/";
    }

    @RequestMapping(value = "/profile", method = RequestMethod.GET)
    public String profile(ModelMap model) {
        int userId = (Integer) model.get("currentId");
        Date date = new Date();
        Timestamp now = new Timestamp(date.getTime());
        model.addAttribute("user", userService.get(userId));
        model.addAttribute("goodsinfoList", goodsService.getUserAll(userId));
        model.addAttribute("bidinfoList", bidService.getBidByUser(userId));
        model.addAttribute("commentinfoList", commentService.getCommentByUser(userId));
        model.addAttribute("complaininfoList", complainService.getComplainByUser(userId));
        model.addAttribute("now", now);
        return "profile";
    }

    @RequestMapping(value = "/profile", method = RequestMethod.POST)
    public String updateProfile(@RequestParam String password,@RequestParam String repassword, ModelMap model, RedirectAttributesModelMap redirectModel) {
        redirectModel.addFlashAttribute("tab", "profile");
        if (password.equals(repassword)) {
            userService.updatePassword((Integer) model.get("currentId"), password);
        }else {
            redirectModel.addFlashAttribute("profileError", "has-error");
        }
        return "redirect:/profile";
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    public String updateStatus(@RequestParam int id, @RequestParam String status, ModelMap model, RedirectAttributesModelMap redirectModel) {
        if (userService.updateStatus(id, status)) {
        }else {
            redirectModel.addFlashAttribute("updateError", "has-error");
        }
        return "redirect:/user/" + id;
    }
}
