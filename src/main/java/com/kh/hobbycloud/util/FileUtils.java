package com.kh.hobbycloud.util;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import lombok.extern.slf4j.Slf4j;


@Slf4j
@Component("fileUtils")
public class FileUtils {
	
	@Autowired
	private String STOREPATH_LEC;
     
    public List<Map<String,Object>> parseInsertFileInfo(Map<String,Object> map, HttpServletRequest req) throws Exception{
    	
        MultipartHttpServletRequest mulReq = (MultipartHttpServletRequest)req;
         
        String lecFileUserName = null;
        String original_Extension = null;
        String lecFileServerName = null;
        String lecFileType = null;//타입 추가
 
        MultipartFile mulFile = null;
        Iterator<String> iterator= mulReq.getFileNames();
         
        List<Map<String,Object>> fileList = new ArrayList<Map<String,Object>>();
        Map<String,Object> fileMap = null;
         
        String lecIdx = (String) map.get("lecIdx").toString();
         
        File file = new File(STOREPATH_LEC);
        if(file.exists()==false) {
            file.mkdirs();
        }
         
        while(iterator.hasNext()) {
            mulFile=mulReq.getFile(iterator.next());
             
            if(mulFile.isEmpty()==false) {
            	lecFileUserName = mulFile.getOriginalFilename();
                original_Extension = mulFile.getOriginalFilename().substring(lecFileUserName.lastIndexOf("."));
                lecFileServerName = CommonUtils.getRandomString()+original_Extension;
                lecFileType = mulFile.getContentType();
                
                file = new File(STOREPATH_LEC + lecFileServerName);
                mulFile.transferTo(file);
                 
                fileMap = new HashMap<String,Object>();
                 
                fileMap.put("lec_idx", lecIdx);
                fileMap.put("lec_file_user_name", lecFileUserName);
                fileMap.put("lec_file_server_name", lecFileServerName);
                fileMap.put("lec_file_size", mulFile.getSize());
                fileMap.put("lec_file_type", lecFileType);
                fileList.add(fileMap);
            }
        }
         
        return fileList;
    }
}
