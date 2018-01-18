<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=0.1, maximum-scale=1.0">
		<script src="UI/libs/jquery.js" type="text/javascript"></script>
		<script src="UI/libs/jquery.tmpl.min.js" type="text/javascript"></script>
		<script src="UI/libs/jquery-ui.min.js" type="text/javascript"></script>
		<link href="UI/libs/jquery-ui.min.css" rel="stylesheet"></link>

		<script src="libs/lodash.min.js"></script>
		<script src='libs/anonymousassertion.js'></script>
		<script src="kore-bot-sdk-client.js"></script>
		<script src="UI/chatWindow.js" type="text/javascript"></script>
		<script src="libs/emoji.js" type="text/javascript"></script>
		<script src="libs/recorder.js" type="text/javascript"></script>
		<script src="libs/recorderWorker.js" type="text/javascript"></script>
		<link href="UI/chatWindow.css" rel="stylesheet"></link>
		<link href="libs/emojione.sprites.css" rel="stylesheet"></link>
		<link href="libs/purejscarousel.css" rel="stylesheet"></link>
		<script src="libs/purejscarousel.js" type="text/javascript"></script>
		<script src="UI/custom/customTemplate.js" type="text/javascript"></script>
		<link href="UI/custom/customTemplate.css" rel="stylesheet"></link>
		
		<script type="text/javascript" src="UI/libs/loader.js"></script>
		<script type="text/javascript" src="libs/speech/app.js"></script>
		<script type="text/javascript" src="libs/speech/key.js"></script>
		<script type="text/javascript" src="libs/client_api.js"></script>
		<script type="text/javascript">
			$(document).on("ready", function () {
				function assertion(options, callback) {
					//var v=document.getElementById("chat-container").value;
					var jsonData = {
						//"clientId": botOptions.clientId,
						//"clientSecret": "",
						//"identity": botOptions.userIdentity,
						//"aud": "",
						//"isAnonymous": false
					};
					$.ajax({
						url: botOptions.koreAPIUrl+"?val="+textEntered,
						type: 'post',
						data: jsonData,
						dataType: 'json',
						success: function (data) {
							//options.assertion = data.jwt;
							//options.handleError = koreBot.showError;
							//options.botDetails = koreBot.botDetails;
							callback(null, options);
							/*setTimeout(function () {
								if (koreBot && koreBot.initToken) {
									koreBot.initToken(options);
								}
							}, 2000);*/
						},
						error: function (err) {
							koreBot.showError(err.responseText);
						}
					});
				}

				var botOptions = {};
				botOptions.logLevel = 'debug';
				botOptions.koreAPIUrl = "http://localhost:9090/ChatBot/chatServlet";
				//botOptions.koreSpeechAPIUrl = "https://speech.kore.ai/";
				//botOptions.bearer = "bearer xyz-------------------";
				//botOptions.ttsSocketUrl = 'wss://speech.kore.ai/tts/ws';
				//botOptions.userIdentity = 'userIdentity';// Provide users email id here
				//botOptions.recorderWorkerPath = '../libs/recorderWorker.js';
				//botOptions.assertionFn = assertion;
				//botOptions.koreAnonymousFn = koreAnonymousFn;
				//botOptions.clientId   = "your clientId"; // secure client-id
				botOptions.botInfo = {name:"your bot name","_id":"bot_id"}; // bot name is case sensitive
				
				var chatConfig={
					botOptions:botOptions,
					allowIframe: false,
					isSendButton: false,
					isTTSEnabled: true,
					isSpeechEnabled: true,
					allowGoogleSpeech: true
				};
				/** 
					allowGoogleSpeech will use Google cloud service api.
					Google speech key is required for all browsers except chrome.
					On Windows 10, Microsoft Edge will support speech recognization.
				 */
				var koreBot = koreBotChat();
				koreBot.show(chatConfig);
				$('.openChatWindow').click(function () {
					koreBotChat().show(chatConfig);
				});
			});
		</script>
	</head>

	<body>
	<form  method="post">
		<div id="chatContainer">
			<button type="submit" class="openChatWindow">Open Chat Window</button>
		</div>
		</form>
	</body>

</html>