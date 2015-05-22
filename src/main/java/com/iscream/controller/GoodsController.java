package com.iscream.controller;

import com.iscream.service.BidService;
import com.iscream.service.CommentService;
import com.iscream.service.GoodsService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributesModelMap;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.sql.Timestamp;


@Controller
@RequestMapping("/goods")
@SessionAttributes({"currentUser", "currentId"})
public class GoodsController {

    @Resource
    private GoodsService goodsService;

    @Resource
    private BidService bidService;

    @Resource
    private CommentService commentService;

    @RequestMapping(method = RequestMethod.GET)
    public String index(ModelMap model) {
        return "redirect:/";
    }

    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    public String show(@PathVariable("id") int id, ModelMap model) {
        model.addAttribute("goodsinfo", goodsService.get(id));
        model.addAttribute("bidinfoByGoodsList", bidService.getBidByGoods(id));
        model.addAttribute("commentinfoByGoodsList", commentService.getCommentByGoods(id));
        return "goods";
    }

    @RequestMapping(method = RequestMethod.POST)
    public String create(HttpServletRequest request, @RequestParam String title, @RequestParam String content, @RequestParam int price, @RequestParam String datetime, @RequestParam MultipartFile file, ModelMap model, RedirectAttributesModelMap redirectModel) {
        if (!file.isEmpty()) {
            String name = file.getOriginalFilename();
            String upload = request.getSession().getServletContext().getRealPath("/images/upload/");
            Timestamp deadline = Timestamp.valueOf(datetime.replace("T", " ") + ":00");
            String pic = datetime.replace("T","-").replace(":","-").replace(" ", "-") + "-" + name;
            String picfile = upload + "\\" + pic;
            String currentUser = (String) model.get("currentUser");
            try {
                FileCopyUtils.copy(file.getBytes(), new File(picfile));
                if (goodsService.create(currentUser,title, content, price, deadline, pic)){
                    return "redirect:/";
                }else{
                    redirectModel.addFlashAttribute("goodsError", "has-error");
                    return "redirect:/";
                }
            } catch (Exception e) {
                redirectModel.addFlashAttribute("goodsError", "has-error");
                return "redirect:/";
            }
        } else {
            redirectModel.addFlashAttribute("goodsError", "has-error");
            return "redirect:/";
        }
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    public String updateStatus(@RequestParam int id, @RequestParam String status, ModelMap model, RedirectAttributesModelMap redirectModel) {
        if (goodsService.updateStatus(id, status)) {
        }else {
            redirectModel.addFlashAttribute("updateError", "has-error");
        }
        return "redirect:/goods/" + id;
    }

    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    public String destroy(@RequestParam int id, ModelMap model, RedirectAttributesModelMap redirectModel) {
        if (goodsService.delete(id)){
        }else{
            redirectModel.addAttribute("goodsDeleteError", "has-error");
        }
        return "redirect:/goods/" + id;
    }
}
