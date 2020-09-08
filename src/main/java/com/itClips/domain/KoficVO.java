package com.itClips.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter @Getter
@ToString
public class KoficVO {
	String koficId,
		   title,
		   openDt,
		   salesAcc,
		   audiAcc,
		   movieId;
}
