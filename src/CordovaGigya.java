package us.platan.gigya;

import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaInterface;
import org.apache.cordova.CordovaWebView;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.text.TextUtils;
import android.util.Log;
import android.support.v4.app.FragmentActivity;
import android.support.v4.app.FragmentTransaction;

import com.gigya.socialize.GSObject;
import com.gigya.socialize.GSResponse;
import com.gigya.socialize.GSResponseListener;
import com.gigya.socialize.android.GSAPI;
import com.gigya.socialize.android.GSSession;
import com.gigya.socialize.android.event.GSLoginUIListener;
import com.gigya.socialize.android.event.GSSocializeEventListener;

public class CordovaGigya extends CordovaPlugin {

    private static final String TAG = "CordovaGigya";

    public boolean execute(String action, JSONArray args, final CallbackContext callbackContext) throws JSONException {
        Log.d(TAG, action);

        if ("initialize".equals(action)) {

            GSAPI.getInstance().initialize(cordova.getActivity(), args.getString(0));
            callbackContext.success();

            return true;

        }
        else if ("showLoginUI".equals(action)) {

            // Get the providers
            JSONArray providers = args.optJSONArray(0);

            // options
            JSONObject paramsJSON = args.optJSONObject(1);

            // Prepare params object
            GSObject params = null;

            if(paramsJSON != null){
                try {
                    params = new GSObject(paramsJSON.toString());
                } catch (Exception e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                }
            }
            else {
                params = new GSObject();
            }

            // Providers
            if(providers != null &&  providers.length() > 0){
                params.put("enabledProviders", providers.join(",").replace("\"", ""));
            }

            // Present the Login user interface.
            GSAPI.getInstance().showLoginUI(params, new GSLoginUIListener() {
                @Override
                public void onLoad(Object context) {
                    Log.d(TAG, "Gigya loginUI was loaded");
                }

                @Override
                public void onError(GSResponse response, Object context) {
                    Log.d(TAG, "Gigya loginUI had an error - " + response.getErrorMessage());
                    callbackError(response, callbackContext);
                }

                @Override
                public void onClose(boolean canceled, Object context) {
                    Log.d(TAG, "Gigya loginUI was closed");
                }

                @Override
                public void onLogin(String provider, GSObject user, Object context) {
                    Log.d(TAG, "Gigya loginUI has logged in");
                    callbackSuccess(user, callbackContext);
                }
            }, null);

            return true;
        } else if ("login".equals(action)) {

            // Get the providers
            String provider = args.optString(0);

            // options
            JSONObject paramsJSON = args.optJSONObject(1);

            // Prepare params object
            GSObject params = null;

            if(paramsJSON != null){
                try {
                    params = new GSObject(paramsJSON.toString());
                } catch (Exception e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                }
            }
            else {
                params = new GSObject();
            }

            // Provider
            if (provider != null && provider != "") {
                params.put("provider", provider);
            }

            // Present the Login user interface.
            try {
                GSAPI.getInstance().login(params, new GSResponseListener() {
                    @Override
                    public void onGSResponse(String method, GSResponse response, Object context) {
                        if (response.getErrorCode() == 0) {
                            callbackSuccess(response, callbackContext);
                        } else {
                            callbackError(response, callbackContext);
                        }
                    }
                }, null);
            } catch (Exception e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }

            return true;
        } else if ("getSession".equals(action)) {

            GSSession session = GSAPI.getInstance().getSession();
            callbackContext.success(session.toString());

            return true;
        }
        else if ("sendRequest".equals(action)){

            String method = args.getString(0);
            JSONObject paramsJSON = args.optJSONObject(1);

            GSObject params = null;

            if(paramsJSON != null){
                try {
                    params = new GSObject(paramsJSON.toString());
                } catch (Exception e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                }
            }

            GSAPI.getInstance().sendRequest(method, params, new GSResponseListener() {
                @Override
                public void onGSResponse(String method, GSResponse response, Object context) {
                    if (response.getErrorCode() == 0) {
                        callbackSuccess(response, callbackContext);
                    } else {
                        callbackError(response, callbackContext);
                    }
                }
            }, null);

            return true;
        }
        else if ("logout".equals(action)){

            GSAPI.getInstance().logout();
            callbackContext.success();

            return true;
        }
        return false;  // Returning false results in a "MethodNotFound" error.
    }


    private void callbackSuccess(GSResponse response, CallbackContext callbackContext){
        JSONObject data = null;
        try {
            data = new JSONObject(response.getData().toJsonString());
        } catch (JSONException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        callbackContext.success(data);
    }

    private void callbackSuccess(GSObject response, CallbackContext callbackContext){
        JSONObject data = null;
        try {
            data = new JSONObject(response.toJsonString());
        } catch (JSONException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        callbackContext.success(data);
    }

    private void callbackError(GSResponse response, CallbackContext callbackContext){
        JSONObject data = null;
        try {
            data = new JSONObject(response.getData().toJsonString());
        } catch (JSONException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        callbackContext.error(data);
    }
}
