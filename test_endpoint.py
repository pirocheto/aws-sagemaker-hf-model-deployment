import json

import boto3

AWS_REGION = "us-east-1"
ENDPOINT_NAME = "dev-multilingual-sentiment-analysis-endpoint"

sagemaker_runtime = boto3.client("sagemaker-runtime", region_name=AWS_REGION)

texts = [
    # English
    "I absolutely love the new design of this app!",
    "The customer service was disappointing.",
    "The weather is fine, nothing special.",
    # Chinese
    "这家餐厅的菜味道非常棒！",
    "我对他的回答很失望。",
    "天气今天一般。",
    # Spanish
    "¡Me encanta cómo quedó la decoración!",
    "El servicio fue terrible y muy lento.",
    "El libro estuvo más o menos.",
    # Arabic
    "الخدمة في هذا الفندق رائعة جدًا!",
    "لم يعجبني الطعام في هذا المطعم.",
    "كانت الرحلة عادية。",
    # Ukrainian
    "Мені дуже сподобалася ця вистава!",
    "Обслуговування було жахливим.",
    "Книга була посередньою。",
    # Hindi
    "यह जगह सच में अद्भुत है!",
    "यह अनुभव बहुत खराब था।",
    "फिल्म ठीक-ठाक थी।",
    # Bengali
    "এখানকার পরিবেশ অসাধারণ!",
    "সেবার মান একেবারেই খারাপ।",
    "খাবারটা মোটামুটি ছিল।",
    # Portuguese
    "Este livro é fantástico! Eu aprendi muitas coisas novas e inspiradoras.",
    "Não gostei do produto, veio quebrado.",
    "O filme foi ok, nada de especial.",
    # Japanese
    "このレストランの料理は本当に美味しいです！",
    "このホテルのサービスはがっかりしました。",
    "天気はまあまあです。",
    # Russian
    "Я в восторге от этого нового гаджета!",
    "Этот сервис оставил у меня только разочарование.",
    "Встреча была обычной, ничего особенного.",
    # French
    "J'adore ce restaurant, c'est excellent !",
    "L'attente était trop longue et frustrante.",
    "Le film était moyen, sans plus.",
    # Turkish
    "Bu otelin manzarasına bayıldım!",
    "Ürün tam bir hayal kırıklığıydı.",
    "Konser fena değildi, ortalamaydı.",
    # Italian
    "Adoro questo posto, è fantastico!",
    "Il servizio clienti è stato pessimo.",
    "La cena era nella media.",
    # Polish
    "Uwielbiam tę restaurację, jedzenie jest świetne!",
    "Obsługa klienta była rozczarowująca.",
    "Pogoda jest w porządku, nic szczególnego.",
    # Tagalog
    "Ang ganda ng lugar na ito, sobrang aliwalas!",
    "Hindi maganda ang serbisyo nila dito.",
    "Maayos lang ang palabas, walang espesyal.",
    # Dutch
    "Ik ben echt blij met mijn nieuwe aankoop!",
    "De klantenservice was echt slecht.",
    "De presentatie was gewoon oké, niet bijzonder.",
    # Malay
    "Saya suka makanan di sini, sangat sedap!",
    "Pengalaman ini sangat mengecewakan.",
    "Hari ini cuacanya biasa sahaja.",
    # Korean
    "이 가게의 케이크는 정말 맛있어요!",
    "서비스가 너무 별로였어요.",
    "날씨가 그저 그렇네요.",
    # Swiss German
    "Ich find dä Service i de Beiz mega guet!",
    "Däs Esä het mir nöd gfalle.",
    "D Wätter hüt isch so naja.",
]

response = sagemaker_runtime.invoke_endpoint(
    EndpointName=ENDPOINT_NAME,
    ContentType="application/json",
    Body=json.dumps(texts),
)


result = json.loads(response["Body"].read().decode())
print("Predicted sentiment:", result)
