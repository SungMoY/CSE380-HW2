precision mediump float;

varying vec4 v_Position;
uniform vec4 laser_Color;

/**
 * Macros that define constants used in the fragment shader program. 
 */
#define MIN_DISTANCE 0.00
#define MAX_DISTANCE 0.02
#define MIDLINE 0.0

/**
 *  This function generates the appropriate alpha value for the fragment color
 *  to render a laser that looks like a sin wave. The alpha value depends on 
 *  the distance of the vertex position from the sine waves curve. Positions
 *  closer to the curve of the sin wave should have a higher alpha value.
 *
 *  +------------------------------------------------------+
 *  | 	   __	  __	 __		__	   __	  __		   | 
 *  | 	  /	 \	 /	\	/  \   /  \	  /	 \	 /	\		   |
 *  |   _/	  \_/	 \_/	\_/	   \_/	  \_/	 \_		   |  
 *  | 													   |
 *  +------------------------------------------------------+
 *
 *  @param position - the position from the vertex shader (v_Position)
 *  @return - the alpha value of the fragment color
 */
float sinwave_laser(vec4 position);

/**
 *  This function generates the appropriate alpha value for the fragment shader
 *  to render a laser that is a straight line. The alpha value depends on the
 *  distance of the vertex fragments position from the midline of the lasers
 *  bounding rectangle. 
 *
 *  +------------------------------------------------------+
 *  | 													   |
 *  + -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  - + <- this is the midline
 *  |													   |
 *  +------------------------------------------------------+
 */
float linear_laser(vec4 position);

void main(){
    gl_FragColor = laser_Color;
	gl_FragColor.a = sinwave_laser(v_Position);
}

float sinwave_laser(vec4 position) {
    float dist = abs(position.y - (sin(position.x * 100.0) * 0.01)); // calculate distance from sine wave
    float alpha = 1.0 - smoothstep(MIN_DISTANCE, MAX_DISTANCE, dist); // calculate alpha based on distance from wave
    return alpha;
}

float linear_laser(vec4 position) {
	float dist = distance(position.y, MIDLINE);
	return 1.0 - smoothstep(MIN_DISTANCE, MAX_DISTANCE, dist);
}


