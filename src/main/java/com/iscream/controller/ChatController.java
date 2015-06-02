package com.iscream.controller;

import com.iscream.service.ChatService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import javax.annotation.Resource;
import java.util.Collections;

@Controller
@RequestMapping("/chat")
@SessionAttributes({"currentUser", "currentId"})
public class ChatController {

    @Resource
    private ChatService chatService;

    @RequestMapping(method = RequestMethod.GET)
    public String index(@RequestParam(defaultValue = "1") int page, ModelMap model) {
        model.addAttribute("chatinfoList", chatService.getPage(page));
        model.addAttribute("page", page);
        return "chat";
    }

    @RequestMapping(value = "/message", method = RequestMethod.GET)
    public String message(@RequestParam(defaultValue = "1") int page, ModelMap model) {
        model.addAttribute("chatinfoList", chatService.getPage(page));
        model.addAttribute("page", page);
        return "message";
    }

    @RequestMapping(method = RequestMethod.POST)
    public String chat(@RequestParam String content, ModelMap model) {
        String currentUser = (String) model.get("currentUser");
        if (chatService.chat(currentUser, content)){
        }else{
            model.addAttribute("chatError", "has-error");
        }
        return "redirect:/chat";
    }
}
