global class WeatherApp implements Process.Plugin { 

// The main method to be implemented. The Flow calls this at runtime.
global Process.PluginResult invoke(Process.PluginRequest request) { 
        // Get the State and City From Flow
        String State = (String) request.inputParameters.get('state');
        String City = (String) request.inputParameters.get('city');
        
        // Use the API to call and fetch Weather Info
         WeatherInfo weatherinformation=new WeatherInfo();
    
        // Instantiate a new http object
         Http h = new Http();

        // Instantiate a new HTTP request, specify the method (GET) as well as the endpoint
         HttpRequest req = new HttpRequest();
         String requestURL='http://api.wunderground.com/api/551013da52923e43/conditions/q/';//One needs to generate the API Key From the http://api.wunderground.com
         requestURL=requestURL+state+'/'+city+'.json';
         req.setEndpoint(requestURL);
         req.setMethod('GET');

        // Send the request, and return a response
        HttpResponse res = h.send(req);
        weatherinformation=(WeatherInfo)JSON.deserialize(res.getBody(), WeatherInfo.class);

        // return to Flow
        Map<String,Object> result = new Map<String,Object>();
        result.put('temperature',weatherinformation.Current_observation.temp_c); 
        result.put('faherneit',weatherinformation.Current_observation.temp_f);
        result.put('dewpoint_f',weatherinformation.Current_observation.dewpoint_f);
        return new Process.PluginResult(result); 
    } 

    // Returns the describe information for the interface
    global Process.PluginDescribeResult describe() { 
        Process.PluginDescribeResult result = new Process.PluginDescribeResult(); 
        result.Name = 'weatherappplugin';
        result.Tag = 'weatherapp';
        result.inputParameters = new 
           List<Process.PluginDescribeResult.InputParameter>{ 
               new Process.PluginDescribeResult.InputParameter('state', 
               Process.PluginDescribeResult.ParameterType.STRING, true) ,
               new Process.PluginDescribeResult.InputParameter('city', 
               Process.PluginDescribeResult.ParameterType.STRING, true) 
            }; 
        result.outputParameters = new 
           List<Process.PluginDescribeResult.OutputParameter>{
            // Temperature obtained From The webservice
            new Process.PluginDescribeResult.OutputParameter(
                'temperature', 
                Process.PluginDescribeResult.ParameterType.Double),
             new Process.PluginDescribeResult.OutputParameter(
                'faherneit', 
                Process.PluginDescribeResult.ParameterType.Double),
             new Process.PluginDescribeResult.OutputParameter(
                'dewpoint_f', 
                Process.PluginDescribeResult.ParameterType.Integer)
           }; 
        return result; 
    }
}