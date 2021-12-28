package com.kh.hobbycloud.entity.gather;

import java.util.List;

import lombok.Data;

@Data
public class GatherSearchDto {
	private String title;
	private List<String> location;
}
