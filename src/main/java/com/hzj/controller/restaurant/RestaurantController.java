package com.hzj.controller.restaurant;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.hzj.controller.common.BaseController;
import com.hzj.service.restaurant.RestaurantService;
import com.hzj.util.AppUtil;
import com.hzj.util.Const;
import com.hzj.util.Page;
import com.hzj.util.PageData;

/**
 * 类名称：RestaurantController 创建人：FH 创建时间：2016-03-15
 */
@Controller
@RequestMapping(value = "/restaurant")
public class RestaurantController extends BaseController {

	String menuUrl = "restaurant/list.do"; // 菜单地址(权限用)
	@Resource(name = "restaurantService")
	private RestaurantService restaurantService;

	/**
	 * 新增
	 */
	@RequestMapping(value = "/save")
	@ResponseBody
	public Map<String, Object> save() throws Exception {
		logBefore(logger, "create restaurant");
		Map<String, Object> map = new HashMap<>();
		PageData pd = new PageData();
		pd = this.getPageData();
		// pd.put("RESTAURANT_ID", this.get32UUID()); // 主键
		restaurantService.save(pd);
		map.put("msg", "success");
		return map;
	}

	/**
	 * 删除
	 */
	@RequestMapping(value = "/delete")
	public void delete(PrintWriter out) {
		logBefore(logger, "删除Restaurant");
		PageData pd = new PageData();
		try {
			pd = this.getPageData();
			restaurantService.delete(pd);
			out.write("success");
			out.close();
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}

	}

	/**
	 * 修改
	 */
	@RequestMapping(value = "/edit")
	@ResponseBody
	public Map<String, Object> edit() throws Exception {
		logBefore(logger, "update restaurant info");
		Map<String, Object> map = new HashMap<>();
		PageData pd = new PageData();
		pd = this.getPageData();
		restaurantService.edit(pd);
		map.put("msg", "success");
		return map;
	}

	/**
	 * 通过ID获取餐厅信息
	 */
	@RequestMapping(value = "/enter")
	public ModelAndView findById() {
		logBefore(logger, "get restaurant info");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		try {
			pd = this.getPageData();
			pd = restaurantService.findById(pd); // 列出Restaurant列表
			mv.setViewName("restaurant/rest_center");
			mv.addObject("pd", pd);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}

	/**
	 * 列表
	 */
	@RequestMapping(value = "/list")
	public ModelAndView list(Page page) {
		logBefore(logger, "列表Restaurant");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		try {
			pd = this.getPageData();
			page.setPd(pd);
			List<PageData> varList = restaurantService.list(page); // 列出Restaurant列表
			mv.setViewName("restaurant/restaurant/restaurant_list");
			mv.addObject("varList", varList);
			mv.addObject("pd", pd);
			mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}

	/**
	 * 去新增页面
	 */
	@RequestMapping(value = "/goAdd")
	public ModelAndView goAdd() {
		logBefore(logger, "去新增Restaurant页面");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			mv.setViewName("restaurant/restaurant/restaurant_edit");
			mv.addObject("msg", "save");
			mv.addObject("pd", pd);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}

	/**
	 * 去修改页面
	 */
	@RequestMapping(value = "/goEdit")
	public ModelAndView goEdit() {
		logBefore(logger, "去修改Restaurant页面");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			pd = restaurantService.findById(pd); // 根据ID读取
			mv.setViewName("restaurant/restaurant/restaurant_edit");
			mv.addObject("msg", "edit");
			mv.addObject("pd", pd);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}

	/**
	 * 批量删除
	 */
	@RequestMapping(value = "/deleteAll")
	@ResponseBody
	public Object deleteAll() {
		logBefore(logger, "批量删除Restaurant");
		PageData pd = new PageData();
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			pd = this.getPageData();
			List<PageData> pdList = new ArrayList<PageData>();
			String DATA_IDS = pd.getString("DATA_IDS");
			if (null != DATA_IDS && !"".equals(DATA_IDS)) {
				String ArrayDATA_IDS[] = DATA_IDS.split(",");
				restaurantService.deleteAll(ArrayDATA_IDS);
				pd.put("msg", "ok");
			} else {
				pd.put("msg", "no");
			}
			pdList.add(pd);
			map.put("list", pdList);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		} finally {
			logAfter(logger);
		}
		return AppUtil.returnObject(pd, map);
	}

	/*
	 * 导出到excel
	 * 
	 * @return
	 */
	@RequestMapping(value = "/excel")
	public ModelAndView exportExcel() {
		logBefore(logger, "导出Restaurant到excel");
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			Map<String, Object> dataMap = new HashMap<String, Object>();
			List<String> titles = new ArrayList<String>();
			titles.add("餐厅名称"); // 1
			titles.add("餐厅地址"); // 2
			titles.add("餐厅信息"); // 3
			titles.add("餐厅电话"); // 4
			titles.add("经营类型"); // 5
			titles.add("营业状态"); // 6
			titles.add("营业时间"); // 7
			titles.add("餐厅图片"); // 8
			dataMap.put("titles", titles);
			List<PageData> varOList = restaurantService.listAll(pd);
			List<PageData> varList = new ArrayList<PageData>();
			for (int i = 0; i < varOList.size(); i++) {
				PageData vpd = new PageData();
				vpd.put("var1", varOList.get(i).getString("RESTAURANTNAME")); // 1
				vpd.put("var2", varOList.get(i).getString("ADDRESS")); // 2
				vpd.put("var3", varOList.get(i).getString("INFO")); // 3
				vpd.put("var4", varOList.get(i).getString("TELPHONE")); // 4
				vpd.put("var5", varOList.get(i).getString("TYPE")); // 5
				vpd.put("var6", varOList.get(i).get("STATUS").toString()); // 6
				vpd.put("var7", varOList.get(i).getString("WORKTIME")); // 7
				vpd.put("var8", varOList.get(i).getString("PICTURE")); // 8
				varList.add(vpd);
			}
			dataMap.put("varList", varList);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}

	/* ===============================权限================================== */
	public Map<String, String> getHC() {
		Subject currentUser = SecurityUtils.getSubject(); // shiro管理的session
		Session session = currentUser.getSession();
		return (Map<String, String>) session.getAttribute(Const.SESSION_QX);
	}
	/* ===============================权限================================== */

	@InitBinder
	public void initBinder(WebDataBinder binder) {
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format, true));
	}
}
