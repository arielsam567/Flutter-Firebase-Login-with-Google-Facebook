# Login com Firebase

## Libs utilizadas
```
  firebase_auth: ^3.6.0
  firebase_core: ^1.0.1
  google_sign_in: ^5.4.1
  flutter_login_facebook: ^1.2.0  
  sign_in_with_apple: ^4.1.0
  twitter_login: ^4.1.0-dev
```

## Configuração para google_sign_in

### 1. Para android, obter o SHA-1 e SHA-256 para inserir no firebase
```
 $ cd android
 $ ./gradlew signingReport
```

### 2. Para IOS, inserir no info.plist,
```
<!-- Google Sign-in Section -->
<key>CFBundleURLTypes</key>
<array>
	<dict>
		<key>CFBundleTypeRole</key>
		<string>Editor</string>
		<key>CFBundleURLSchemes</key>
		<array>
			<!-- TODO Replace this value: -->
			<!-- Copied from GoogleService-Info.plist key REVERSED_CLIENT_ID -->
			<string>com.googleusercontent.apps.861823949799-vc35cprkp249096uujjn0vvnmcvjppkn</string>
		</array>
	</dict>
</array>
<!-- End of the Google Sign-in Section -->
```

VERSAO MINIMA COM flutter_login_facebook: ^1.2.0 É IOS 12

## Configuração para flutter_login_facebook

### 1. Para android, criar o arquivo strings.xml localizado em android/app/src/main/res/values/
```xml
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <string name="app_name">[NAME]</string>
    <string name="facebook_app_id">[FACEBOOK_APP_ID]</string>
    <string name="facebook_client_token">[FACEBOOK_CLIENT_TOKEN]</string>
    <string name="fb_login_protocol_scheme">fb[FACEBOOK_APP_ID]</string>
</resources>
```

### 2. Adicionar ao AndroidManifest.xml
```xml
    [...]
    <uses-permission android:name="android.permission.INTERNET"/>
    <queries>
    <provider android:authorities="com.facebook.katana.provider.PlatformProvider" />
    </queries>
    [...]

    <!-- START FACEBOOK CONFIG -->
    <meta-data android:name="com.facebook.sdk.ApplicationId" android:value="@string/facebook_app_id"/>
    <meta-data android:name="com.facebook.sdk.ClientToken" android:value="@string/facebook_client_token"/>
    
    <activity android:name="com.facebook.FacebookActivity"
    android:configChanges=
        "keyboard|keyboardHidden|screenLayout|screenSize|orientation"
    android:label="@string/app_name" />
    <activity
    android:name="com.facebook.CustomTabActivity"
    android:exported="true">
    <intent-filter>
        <action android:name="android.intent.action.VIEW" />
        <category android:name="android.intent.category.DEFAULT" />
        <category android:name="android.intent.category.BROWSABLE" />
        <data android:scheme="@string/fb_login_protocol_scheme" />
    </intent-filter>
    </activity>
    <!-- END FACEBOOK CONFIG -->
```

### 4. Adicionar ao info.plist, inserir dentro do array de CFBundleURLTypes
```
<key>CFBundleURLTypes</key>
	<array>
		[...]
		<dict>
			<key>CFBundleURLSchemes</key>
			<array>
				<string>fb[APP_ID]</string>
			</array>
		</dict>
	</array>
```

### 5. Adicionar ao info.plist
```
    [...]
    <key>FacebookAppID</key>
	<string>[APP_ID]</string>
	<key>FacebookClientToken</key>
	<string>[FACEBOOK_CLIENT_TOKEN]</string>
	<key>FacebookDisplayName</key>
	<string>[APP_NAME]</string>
	<key>LSApplicationQueriesSchemes</key>
	<array>
		<string>fbapi</string>
		<string>fb-messenger-share-api</string>
	</array>
```

## Configuração para sign_in_with_apple

### 1. Adicionar ao AndroidManifest.xml
```xml
    [...]
    <activity
        android:name="com.aboutyou.dart_packages.sign_in_with_apple.SignInWithAppleCallback"
        android:exported="true"
    >
        <intent-filter>
            <action android:name="android.intent.action.VIEW" />
            <category android:name="android.intent.category.DEFAULT" />
            <category android:name="android.intent.category.BROWSABLE" />
    
            <data android:scheme="signinwithapple" />
            <data android:path="callback" />
        </intent-filter>
    </activity>
```

### 2. Configurando para IOS

Abrir Xcode -> Targets -> Runner -> Signing & Capabilities -> + Capability -> Selecione a opção "Sign in with Apple".

Para isso, você já deve ter configurado o seu app na Apple Store Connect 

## Configuração para twitter_login

### 1. Configurando o AndroidManifest.xml
```xml
[...]
            <!--  START TWITTER CONFIG-->
            <intent-filter>
                <action android:name="android.intent.action.VIEW" />

                <category android:name="android.intent.category.DEFAULT" />
                <category android:name="android.intent.category.BROWSABLE" />
                <!-- Accepts URIs that begin with "example://gizmos” -->
                <!-- Registered Callback URLs in TwitterApp -->
                <data
                    android:host="[HOST]"
                    android:scheme="[HOST]" /> <!-- host is option -->
            </intent-filter>
            <!--  END TWITTER CONFIG-->
[...]
```

### 2. Adicionar ao info.plist, inserir dentro do array de CFBundleURLTypes
```
<key>CFBundleURLTypes</key>
	<array>
		[...]
		<dict>
            <key>CFBundleTypeRole</key>
            <string>Editor</string>
            <key>CFBundleURLName</key>
            <string>[APP_NAME]</string>
            <key>CFBundleURLSchemes</key>
            <array>
              <!-- Registered Callback URLs in TwitterApp -->
              <string>[HOST]</string>
            </array>
        </dict>
	</array>
```