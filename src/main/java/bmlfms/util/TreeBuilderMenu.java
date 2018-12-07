package bmlfms.util;

import java.util.ArrayList;
import java.util.List;

import javax.print.DocFlavor.STRING;


import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.serializer.SerializerFeature;

import bmlfms.entity.Menu;


public class TreeBuilderMenu {
	
	List<Menu> nodes = new ArrayList<>();

    public String buildTree(List<Menu> nodes) {

        TreeBuilderMenu treeBuilder = new TreeBuilderMenu(nodes);

        return treeBuilder.buildJSONTree();
    }

    public TreeBuilderMenu() {
    }

    public TreeBuilderMenu(List<Menu> nodes) {
        super();
        this.nodes = nodes;
    }

    // 构建JSON树形结构
    public String buildJSONTree() {
        List<Menu> nodeTree = buildTree();
        JSON.DEFFAULT_DATE_FORMAT = "yyyy-MM-dd HH:mm:ss";
        return JSON.toJSONString(nodeTree, SerializerFeature.WriteDateUseDateFormat);
    }

    // 构建树形结构
    public List<Menu> buildTree() {
        List<Menu> treeNodes = new ArrayList<>();
        List<Menu> rootNodes = getRootNodes();
        for (Menu rootNode : rootNodes) {
            buildChildNodes(rootNode);
            treeNodes.add(rootNode);
        }
        return treeNodes;
    }

    // 递归子节点
    public void buildChildNodes(Menu node) {
        List<Menu> children = getChildNodes(node);
        if (!children.isEmpty()) {
            for (Menu child : children) {
                buildChildNodes(child);
            }
            node.setChildren(children);
        }
    }

    // 获取父节点下所有的子节点
    public List<Menu> getChildNodes(Menu pnode) {
        List<Menu> childNodes = new ArrayList<>();
        for (Menu n : nodes) {
            if (pnode.getMenuId()==n.getPid()) {
                childNodes.add(n);
            }
        }
        return childNodes;
    }

    // 判断是否为根节点
    public boolean rootNode(Menu node) {
        boolean isRootNode = true;
        for (Menu n : nodes) {
            if (node.getPid()==n.getMenuId()) {
                isRootNode = false;
                break;
            }
        }
        return isRootNode;
    }

    // 获取集合中所有的根节点
    public List<Menu> getRootNodes() {
        List<Menu> rootNodes = new ArrayList<>();
        for (Menu n : nodes) {
            if (rootNode(n)) {
                rootNodes.add(n);
            }
        }
        return rootNodes;
    }

}
