import 'package:flutter_dog_adviser/models/bmi/bmi_repository.dart';
import 'package:flutter_dog_adviser/models/bmi/sembast_bmi_repository.dart';
import 'package:flutter_dog_adviser/models/dog/dog_repository.dart';
import 'package:flutter_dog_adviser/models/dog/sembast_dog_repository.dart';
import 'package:flutter_dog_adviser/models/food/food_repository.dart';
import 'package:flutter_dog_adviser/models/food/sembast_food_repository.dart';
import 'package:flutter_dog_adviser/models/notify/notify_repository.dart';
import 'package:flutter_dog_adviser/models/notify/sembast_notify_repository.dart';
import 'package:flutter_dog_adviser/models/train/sembast_train_repository.dart';
import 'package:flutter_dog_adviser/models/train/train_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class InitDatabase {
  static Future initialize() async {
    _registerRepositories();
    await _initSembast();
  }

  static _registerRepositories(){
    GetIt.I.registerLazySingleton<DogRepository>(() => SembastDogRepository());
    GetIt.I.registerLazySingleton<FoodRepository>(() => SembastFoodRepository());
    GetIt.I.registerLazySingleton<NotifyRepository>(() => SembastNotifyRepository());
    GetIt.I.registerLazySingleton<TrainRepository>(() => SembastTrainRepository());
    GetIt.I.registerLazySingleton<BMIRepository>(() => SembastBMIRepository());
  }

  static Future _initSembast() async {
    var dogStore = intMapStoreFactory.store('dog_store');
    var foodStore = intMapStoreFactory.store('food_store');
    var trainStore = intMapStoreFactory.store('train_store');
    var bmiStore = intMapStoreFactory.store('bmi_store');

    final appDir = await getApplicationDocumentsDirectory();
    await appDir.create(recursive: true);
    final databasePath = join(appDir.path, "dog_app.db");
    final database = await databaseFactoryIo.openDatabase(databasePath, version: 1,
      onVersionChanged: (database, oldVersion, newVersion) async {
        if (oldVersion == 0) {

          //Init data for dog
          await dogStore.add(database, {
            "dogName": "Boston Terrier",
            "dogNation": "United States",
            "dogImage": "assets/images/dog/boston_terrier.jpg",
            "dogInfo": "Boston Terrier is a breed of dog originating in the United States of America. They should be either black, brindle or seal with white markings. Boston Terriers are small and compact with a short tail and erect ears. They are highly intelligent and very easily trained, friendly and can be stubborn at times. Boston Terrier is also a gentle breed that typically has a strong, happy-go-lucky, and friendly personality with a merry sense of humor.",
            "dogStatistics": "Life span: 11–13 years\nColor:   white, seal with white, black with white\nHeight:   23–38 cm\nWeight:  3–11 kg",
            "dogTags": "Friendly, Smart",
          });
          await dogStore.add(database, {
            "dogName": "Akita",
            "dogNation": "Japan",
            "dogImage": "assets/images/dog/akita.jpg",
            "dogInfo": "Akita is a large breed of dog originating from the mountainous regions of northern Japan. There are two separate varieties of Akita: a Japanese strain, commonly called Akita Inu (inu means dog in Japanese) or Japanese Akita, and an American strain, known as the Akita or American Akita. The Japanese strain comes in a narrow palette of colors, with all other colors considered atypical of the breed, while the American strain comes in all dog colors. The Akita is a powerful, independent and dominant breed, commonly aloof with strangers but affectionate with family members. As a breed, Akitas are generally hardy.",
            "dogStatistics": "Life span: 10 years\nColor:  ginger, red, brindle, or white\nHeight:   64–69 cm\nWeight:   15–18 kg",
            "dogTags": "Friendly, Smart",
          });
          await dogStore.add(database, {
            "dogName": "German Shepherd",
            "dogNation": "Germany",
            "dogImage": "assets/images/dog/german_shepherd.jpg",
            "dogInfo": "German shepherd  is a breed of medium to large-sized working dog that originated in Germany. As a herding dog, German Shepherds are working dogs developed originally for herding sheep. Since that time, however, because of their strength, intelligence, trainability, and obedience, German Shepherds around the world are often the preferred breed for many types of work, including disability assistance, search-and-rescue, police and military roles and acting.",
            "dogStatistics": "Life span: 9–13 years\nColor:  tan with black saddle, sable, solid black or bi-color\nHeight:  60–65 cm\nWeight:  30–40 kg",
            "dogTags": "Aggression, Obedient, Smart",
          });
          await dogStore.add(database, {
            "dogName": "Border Collie",
            "dogNation": "United Kingdom",
            "dogImage": "assets/images/dog/border_collie.jpg",
            "dogInfo": "Border Collie is a working and herding dog breed developed in the Anglo-Scottish border region, for herding livestock, especially sheep. Considered highly intelligent, extremely energetic, acrobatic and athletic, they frequently compete with great success in sheepdog trials and dog sports. They are often cited as the most intelligent of all domestic dogs. Border Collies continue to be employed in their traditional work of herding livestock throughout the world and are kept as pets.",
            "dogStatistics": "Life span: 10–17 years\nColor:   red, black, white, brindle or orange\nHeight:   48–56 cm\nWeight:  14–20 kg",
            "dogTags": "Friendly, Obedient, Smart",
          });
          await dogStore.add(database, {
            "dogName": "Siberian Husky",
            "dogNation": "United States",
            "dogImage": "assets/images/dog/siberian_husky.jpg",
            "dogInfo": "The Siberian Husky is a medium-sized working sled dog breed. Siberian Huskies originated in Northeast Asia where they are bred by the Chukchi people of Siberia for sled-pulling, and companionship. It is an active, energetic, resilient breed, whose ancestors lived in the extremely cold and harsh environment of the Siberian Arctic. Today, the Siberian Husky is typically kept as a house pet, though they are still frequently used as sled dogs.",
            "dogStatistics": "Life span: 12–14 years\nColor:   All colors from black to pure white\nHeight:  53–60 cm\nWeight:  20–27 kg",
            "dogTags": "Friendly, Smart",
          });
          await dogStore.add(database, {
            "dogName": "American Staffordshire",
            "dogNation": "United States",
            "dogImage": "assets/images/dog/american_staffordshire.jpg",
            "dogInfo": "American Staffordshire is a medium-sized, short-coated American dog breed. It was described as confident, smart and good-natured dog breed. American Staffordshire should give the impression of great strength for his size, a well put-together dog, muscular, but agile and graceful, keenly alive to his surroundings. He should be stocky, not long-legged or racy in outline. His courage is proverbial.",
            "dogStatistics": "Life span:   12–16 years\nColor :  white, black and tan\nHeight:   43–48 cm\nWeight:  23–36 kg",
            "dogTags": "Friendly, Smart",
          });
          await dogStore.add(database, {
            "dogName": "Basset Hound",
            "dogNation": "United Kingdom",
            "dogImage": "assets/images/dog/basset_hound.jpg",
            "dogInfo": "Basset Hound is a short-legged breed of dog in the hound family. The Basset is a scent hound that was originally bred for the purpose of hunting hare. Their sense of smell and ability to ground-scent is second only to the Bloodhound.Basset Hounds are one of six recognised \"basset\"-type breeds in France. The name basset is derived from the French word bas, meaning \“low\”.",
            "dogStatistics": "Life span: 10–12 years\nColor:   black, white and tan\nHeight:   30–38 cm\nWeight:  25–34 kg",
            "dogTags": "Friendly",
          });
          await dogStore.add(database, {
            "dogName": "Beagle",
            "dogNation": "England",
            "dogImage": "assets/images/dog/beagle.jpg",
            "dogInfo": "Beagle is a breed of small hound that is similar in appearance to the much larger foxhound. The beagle is a scent hound, developed primarily for hunting hare (beagling). Possessing a great sense of smell and superior tracking instincts, the beagle is the primary breed used as detection dogs for prohibited agricultural imports and foodstuffs in quarantine around the world. The beagle is intelligent. It is a popular pet due to its size, good temper, and a lack of inherited health problems.",
            "dogStatistics": "Life span: 12–15 years\nColor:   white, black, tan/brown or brown/tan\nHeight:     33–41 cm\nWeight:  10–11 kg",
            "dogTags": "Friendly, Obedient, Smart",
          });
          await dogStore.add(database, {
            "dogName": "Bichon Frise",
            "dogNation": "Spain, France, Belgium",
            "dogImage": "assets/images/dog/bichon_frise.jpg",
            "dogInfo": "Bichon Frise is a small dog, The French word bichon comes from Middle French bichon \“small dog\”. The skull is slightly rounded and the muzzle is not pointy. The tail is groomed to be long and curly and is carried over the back. It has a black nose and dark round eyes; its white hair consists of a curly, dense coat with little shedding (much like a poodle in this respect), although many of the breed do tend to have less curly hair than others.",
            "dogStatistics": "Life span: 12–15 years\nColor:   white\nHeight  :  23–28 cm\nWeight:    5–10 kg",
            "dogTags": "Friendly",
          });
          await dogStore.add(database, {
            "dogName": "Bulldog",
            "dogNation": "England",
            "dogImage": "assets/images/dog/bulldog.jpg",
            "dogInfo": "The Bulldog, also known as the English Bulldog or British Bulldog, is a medium-sized dog breed. It is a muscular, hefty dog with a wrinkled face and a distinctive pushed-in nose. They have generally thick folds of skin on the brow; round, black, wide-set eyes; a short muzzle with characteristic folds called a rope or nose roll above the nose; hanging skin under the neck; drooping lips and pointed teeth, and an underbite with an upturned jaw.  Most have a friendly, patient, but stubborn nature and can get aggressive sometimes.",
            "dogStatistics": "Lifespan:  10-11 years\nColor:    red, fawn, white, brindle, and piebald\nHeight:  31-40 cm\nWeight :  18-23 kg",
            "dogTags": "Aggression",
          });
          await dogStore.add(database, {
            "dogName":"Chihuahua",
            "dogNation":"Mexico",
            "dogImage":"assets/images/dog/chihuahua.png",
            "dogInfo":"The Chihuahua is the smallest breed of dog in the world, and is named after the Mexican state of Chihuahua.  They have special attractions and are equally easy to keep clean and well-groomed. Their smooth coat does not mean that the hair is necessarily smooth, as the hair can range from having a velvet touch to a whiskery feel. Current breed standards defined by registries specify an \"apple-head\" or \"apple-dome\" skull conformation.Chihuahuas have large, round eyes and large, erect ears, set in a high, dramatically rounded skull.",
            "dogStatistics":"Life span: 12–20 years\nColor:   Any color\nHeight   15–25 cm\nWeight:  1.8–2.7 kg",
            "dogTags":"Friendly",
          });
          await dogStore.add(database, {
            "dogName":"Chow Chow",
            "dogNation":"China",
            "dogImage":"assets/images/dog/chow_chow.jpg",
            "dogInfo":"Chow Chow is a dog breed originally from northern China. Chow Chow is a sturdily built dog, square in profile, with a broad skull and small, triangular, erect ears with rounded tips. The breed is known for a very dense double coat that is either smooth or rough. The fur is particularly thick in the neck area, giving it a distinctive ruff or mane appearance. The coat may be shaded/self-red, black, blue, cinnamon/fawn, or cream. Most commonly kept as pets, Chow Chows tend to display discernment of strangers and can become fiercely protective of their owners and property.",
            "dogStatistics":"Life span: 11–13 years\nColor:   red, cinnamon, black, tan\nHeight:  43–56 cm\nWeight:  18–41 kg",
            "dogTags":"Aggression",
          });
          await dogStore.add(database, {
            "dogName":"Dachshund",
            "dogNation":"Germany",
            "dogImage":"assets/images/dog/dachshund.jpg",
            "dogInfo":"Dachshund also known as the wiener dog, badger dog, or sausage dog, is a short-legged, long-bodied, hound-type dog breed. They may be smooth, wire, or long-haired. The standard-sized dachshund was developed to scent, chase, and flush out badgers and other burrow-dwelling animals, while the miniature dachshund was bred to hunt small animals such as rabbits and mice. In the Western United States, they have also been used to track wounded deer and hunt prairie dogs.",
            "dogStatistics":"Life span: 12.7 years\nColor:  red, brown, tan\nHeight:  37–47 cm\nWeight :  3.5–14 kg",
            "dogTags":"Smart",
          });
          await dogStore.add(database, {
            "dogName":"Dobermann",
            "dogNation":"Germany",
            "dogImage":"assets/images/dog/dobermann.jpg",
            "dogInfo":"The Dobermann, is a medium-large breed of domestic dog that was originally developed around 1890 by Karl Friedrich Louis Dobermann in Germany. The Dobermann has a long muzzle. It stands on its pads and is not usually heavy-footed. Ideally, they have an even and graceful gait. Dobermanns are known to be intelligent, alert, and tenaciously loyal companions and guard dogs. They also can be easy to train and will learn very quickly.",
            "dogStatistics":"Life span: 9–12 years\nColor:  black & tan, red & tan\nHeight:   68 - 72 cm\nWeight:  40–45 kg",
            "dogTags":"Aggression, Obedient, Smart",
          });
          await dogStore.add(database, {
            "dogName":"English Mastiff",
            "dogNation":"England",
            "dogImage":"assets/images/dog/english_mastiff.jpg",
            "dogInfo":"English Mastiff is a breed of large dog. Distinguished by its enormous size, massive head, short coat in a limited range of colours, and always displaying a black mask, the Mastiff is noted for its gentle and loving nature. With a massive body, broad skull and head of generally square appearance, it is the largest dog breed in terms of mass. English Mastiffs are powerful yet gentle and loyal dogs, but due to their physical size and need for space, are best suited for country or suburban life.",
            "dogStatistics":"Lifespan:  7 years\nColor:   apricot-fawn, silver-fawn, fawn, or dark fawn-brindle\nHeight:  76 cm (min)\nWeight  :  73 - 104 kg",
            "dogTags":"Friendly, Obedient",
          });
          await dogStore.add(database, {
            "dogName":"Golden Retriever",
            "dogNation":"Scotland",
            "dogImage":"assets/images/dog/golden_retriever.jpg",
            "dogInfo":"The Golden Retriever is a medium-large gun dog that was bred to retrieve shot waterfowl, such as ducks and upland game birds, during hunting and shooting parties. Golden retrievers have an instinctive love of water, and are easy to train to basic or advanced obedience standards. They are a long-coated breed, with a dense inner coat that provides them with adequate warmth in the outdoors, and an outer coat that lies flat against their bodies and repels water. Golden retrievers are well suited to residency in suburban or country environments. Golden Retrievers are rarely choosy eaters, but require ample (two or more hours a day) exercise.",
            "dogStatistics":"Life span: 10–12 years\nColor:   gold or cream\nHeight:  56–61 cm\nWeight:  29–34 kg",
            "dogTags":"Friendly, Obedient, Smart",
          });
          await dogStore.add(database, {
            "dogName":"Great Dane",
            "dogNation":"Germany",
            "dogImage":"assets/images/dog/great_dane.jpg",
            "dogInfo":"The Great Dane, also known as the German Mastiff or Deutsche Dogge, is a breed of dog from Germany. The Great Dane descends from hunting dogs known from the Middle Ages and is one of the largest breeds in the world. The Great Dane's large and imposing appearance belies its friendly nature. They are known for seeking physical affection with their owners, and the breed is often referred to as a \"gentle giant\".  However, if not properly socialized, a Great Dane may become fearful or aggressive towards new stimuli, such as strangers and new environments.",
            "dogStatistics":"Life span:  8–10 years\nColor:   black, white, harlequin, gray\nHeight:  80–90 cm\nWeight:  50–82 kg",
            "dogTags":"Friendly",
          });
          await dogStore.add(database, {
            "dogName":"Labrador Retriever",
            "dogNation":"United Kingdom",
            "dogImage":"assets/images/dog/labrador_retriever.jpg",
            "dogInfo":"The Labrador Retriever, often abbreviated to Labrador, is a medium-large gun dog from the United Kingdom that was developed from imported Canadian fishing dogs. The Labrador is one of the most popular dog breeds in a number of countries in the world, particularly in the Western world.A popular disability assistance breed in many countries, Labradors are frequently trained to aid those with blindness or autism, act as a therapy dog, or perform screening and detection work for law enforcement and other official agencies. The breed is best known for their obedience, loyalty, and playful composure.",
            "dogStatistics":"Life span: 10-12 years\nColor:   black, chocolate, or yellow\nHeight:  56–57 cm\nWeight:  29–36 kg",
            "dogTags":"Friendly, Obedient, Smart",
          });
          await dogStore.add(database, {
            "dogName":"Maltese Dog",
            "dogNation":"Central Mediterranean Region",
            "dogImage":"assets/images/dog/maltese_dog.jpg",
            "dogInfo":"The Maltese is a breed of dog in the toy group. It is thought to have originated in south-central Europe from dogs of spitz type, Characteristics include slightly rounded skulls, with a finger-wide dome, a black button nose and brown eyes. The body is compact with the length equaling the height and the tail is almost always curled. The drop ears with \(sometimes\) long hair, and eyes surrounded by darker skin pigmentation \(called a \"halo\"\), gives Maltese their expressive look. Lacking exposure to a lot of sunlight, their noses can fade and become pink or light brown in color. This is often referred to as a \"winter nose\" and many times will become black again with increased exposure to the sun. The Maltese's paws are very sensitive to touch.",
            "dogStatistics":"Life span: 12-15 years\nColor:   white\nHeight:  20–25 cm\nWeight:  1.4–3.6 kg",
            "dogTags":"Friendly",
          });
          await dogStore.add(database, {
            "dogName":"Pomeranian",
            "dogNation":"Pomerania",
            "dogImage":"assets/images/dog/pomeranian.jpg",
            "dogInfo":"The Pomeranian \(often known as a Pom\) is a breed of dog of the Spitz type that is named for the Pomerania region in north-west Poland and north-east Germany in Central Europe. Classed as a toy dog breed because of its small size, the Pomeranian is descended from larger Spitz-type dogs, specifically the German Spitz. Pomeranians are typically friendly, lively and playful. They can be aggressive with other dogs and humans to try to prove themselves. Pomeranians are alert and aware of changes in their environment.",
            "dogStatistics":"Life span: 12 - 16 years\nColor:   white, black, brown, red, orange\nHeight:   18 - 30 cm\nWeight:  1.4 - 3.2 kg",
            "dogTags":"Friendly",
          });
          await dogStore.add(database, {
            "dogName":"Poodle",
            "dogNation":"Germany, France",
            "dogImage":"assets/images/dog/poodle.jpg",
            "dogInfo":"Poodle is  is a breed of water dog. The Poodle is most commonly claimed to have been developed in Germany, although it is also claimed to be from France, the Standard Poodle was originally used by wildfowl hunters to retrieve game from water. The smaller varieties of the breed were bred from the original in France where they were once commonly used as circus performers, but have become popular companion dogs. Poodles are known as a highly intelligent, energetic, and sociable breed. They require both physical and intellectual activities. Poodles are also highly trainable dogs that typically excel in obedience training.",
            "dogStatistics":"Lifespan:	12 - 15 years\nColor:		black, white, brown, gray, apricot, and red\nHeight:		45–62 cm\nWeight:	20–32 kg",
            "dogTags":"Friendly, Obedient, Smart",
          });
          await dogStore.add(database, {
            "dogName":"Rottweiler",
            "dogNation":"Germany",
            "dogImage":"assets/images/dog/rottweiler.jpg",
            "dogInfo":"The Rottweiler is a breed of Germany domestic dog, regarded as medium-to-large or large.\nTheir main use was to herd livestock and pull carts laden with butchered meat to market.\nAlthough still used to herd stock in many parts of the world, Rottweilers are now also used as search and rescue dogs, guard dogs, and police dogs. The Rottweiler is good-natured, placid in basic disposition, very devoted, obedient, biddable and eager to work but can be quite aggressive.",
            "dogStatistics":"Life span:	8–10 years\nColor:		black & tan or black\nHeight:		61–69 cm\nWeight:	50–60 kg",
            "dogTags":"Aggression, Obedient, Smart",
          });
          await dogStore.add(database, {
            "dogName":"Pug",
            "dogNation":"China",
            "dogImage":"assets/images/dog/pug.jpg",
            "dogInfo":"The pug is a breed of dog with physically distinctive features of a wrinkly, short-muzzled face, and curled tail. The breed has a fine, glossy coat that comes in a variety of colours, most often light brown \(fawn\) or black, and a compact, square body with well-developed muscles.\nPugs were brought from China to Europe in the sixteenth century. They have  charming personality, despite its small size. Pugs are strong willed but rarely aggressive, and are suitable for families with children. The majority of the breed is very fond of children and sturdy enough to properly play with them.",
            "dogStatistics":"Lifespan:	12 - 15 years\nColor:		black, brown-yellow, fawn\nHeight:		35 - 46 cm\nWeight:	6 - 8 kg",
            "dogTags":"Friendly",
          });
          await dogStore.add(database, {
            "dogName":"Shih Tzu",
            "dogNation":"China",
            "dogImage":"assets/images/dog/shih_tzu.jpg",
            "dogInfo":"The Shih Tzu is an Asian toy dog breed. This breed is well-known for their short snout and large round eyes, as well as their ever growing coat, floppy ears, and short and stout posture. Although small in size, they are notorious for their largely fun and playful personality, and calm and friendly temperament. They are highly independent dogs, and are able to adapt well in different situations. Though, due to their independent nature, they are not considered the most obedient breed.",
            "dogStatistics":"Life span:	10–18 years\nColor:		gold, brown, white, black, grey\nHeight:		20–28 cm\nWeight:	4–7.5 kg",
            "dogTags":"Friendly",
          });
          await dogStore.add(database, {
            "dogName":"Yorkshire Terrier",
            "dogNation":"England",
            "dogImage":"assets/images/dog/yorkshire_terrier.jpg",
            "dogInfo":"The Yorkshire Terrier \(often shortened as Yorkie\) is one of the smallest dog breeds of the terrier type, and of any dog breed. The breed developed during the 19th century in Yorkshire, England. Yorkshire Terriers are very playful and energetic dogs. Many people who have a Yorkie as a pet have two, because they often have separation anxiety when left alone. Though small, the Yorkshire Terrier is active, very protective, curious, and fond of attention. They are also an easy dog breed to train. This results from their own nature to work without human assistance.",
            "dogStatistics":"Life span: 13 - 16 years\nColor:   tan, black, grey\nHeight:   20 - 23 cm\nWeight:  2 - 3.5 kg",
            "dogTags":"Friendly, Obedient, Smart",
          });

          //Init data for food
          await foodStore.add(database, {
            "foodName": "Avocado",
            "foodType": "Raw food",
            "foodImage":"assets/images/food/avocado.jpg",
            "foodInfo":"Avocados should never be consumed by dogs.\nThis is because they contain a toxin called persin, which is known to be very poisonous to dogs. It may lead to fluid accumulation in their lungs and chest, which can cause breathing difficulties, oxygen deprivation and even death.\nPersin is found in all parts of the avocado, including the fruit, pit, leaves and bark. Thus, you should always keep avocados away from your dog.",
            "foodEdible":"Inedible",
            "foodFor":"None",
          });
          await foodStore.add(database, {
            "foodName": "Banana",
            "foodType": "Raw food",
            "foodImage":"assets/images/food/banana.jpg",
            "foodInfo":"Dogs can eat bananas in moderation.\nBananas are high in fiber and many vitamins and minerals. Some people also claim that bananas help relieve nausea in dogs, but this has not been proven by scientific evidence.\nYou can mix some mashed banana with your dog’s regular food or feed him a slice or two as an occasional treat.",
            "foodEdible":"Edible",
            "foodFor":"All kinds",
          });
          await foodStore.add(database, {
            "foodName": "Beef",
            "foodType": "Raw food",
            "foodImage":"assets/images/food/beef.jpg",
            "foodInfo":"Lean beef is safe for dogs to eat.\nIn fact, beef is a common ingredient in many dog foods. It’s an excellent source of protein and many important vitamins and minerals that your dog needs for overall health.\nThe beef that you feed to your dog should be plain, without any added sauces or seasonings. These often contain ingredients that may be harmful to your dog, such as salt.",
            "foodEdible":"Edible",
            "foodFor":"All kinds",
          });
          await foodStore.add(database, {
            "foodName": "Bread",
            "foodType": "Raw food",
            "foodImage":"assets/images/food/bread.jpg",
            "foodInfo":"Plain white or whole grain bread is safe for most dogs to eat as an occasional treat.\nBefore feeding your dog bread, make sure it doesn’t contain any extra ingredients, such as raisins, which could be potentially harmful.\nAdditionally, keep in mind that bread, along with other foods, adds extra calories to your dog’s diet and may cause weight gain if he eats too much.",
            "foodEdible":"Edible",
            "foodFor":"All kinds",
          });
          await foodStore.add(database, {
            "foodName": "Broccoli",
            "foodType": "Raw food",
            "foodImage":"assets/images/food/brocoli.jpg",
            "foodInfo":"Dogs can eat raw or cooked broccoli in moderation.\nBroccoli is a low-calorie vegetable that contains high amounts of many nutrients, making it a very healthy snack for your dog.\nHowever, broccoli contains isothiocyanates, which are compounds that may irritate your dog’s digestive system if he eats too much. Thus, you should only feed broccoli to your dog as an occasional snack.",
            "foodEdible":"Edible",
            "foodFor":"All kinds",
          });
          await foodStore.add(database, {
            "foodName": "Coffee",
            "foodType": "Raw food",
            "foodImage":"assets/images/food/caffe.jpg",
            "foodInfo":"Coffee is dangerous for dogs to consume due to their caffeine contents.\nCaffeine stimulates your dog’s nervous system, which can lead to a number of symptoms, including hyperactivity, vomiting, diarrhea, elevated heart rate, seizures and tremors.\nLung failure and abnormal heart rhythm may result from too much caffeine, which can ultimately lead to death.\nEven small amounts of caffeine can cause adverse effects in dogs, so you should always keep coffee and tea out of your dog’s reach.",
            "foodEdible":"Inedible",
            "foodFor":"None",
          });
          await foodStore.add(database, {
            "foodName": "Carrot",
            "foodType": "Raw food",
            "foodImage":"assets/images/food/carrot.jpg",
            "foodInfo":"Both raw and cooked carrots are safe for your dog to eat.\nCarrots are low in calories and a good source of vitamins, minerals and fiber. This makes them a very healthy food for your dog to snack on.\nBefore feeding carrots to your dog, make sure to cut them into bite-size pieces to prevent choking.",
            "foodEdible":"Edible",
            "foodFor":"All kinds",
          });
          await foodStore.add(database, {
            "foodName": "Cheese",
            "foodType": "Raw food",
            "foodImage":"assets/images/food/cheese.jpg",
            "foodInfo":"Cheese is safe for most dogs to eat in small quantities.\nDue to the fat and lactose content of cheese, some dogs may have digestive symptoms, such as stomach pain and diarrhea, after eating it.\nTo avoid unpleasant symptoms, it is best to introduce cheese into your dog’s diet gradually. It may also help to only feed your dog low-fat cheeses, such as mozzarella.",
            "foodEdible":"Limit",
            "foodFor":"All kinds",
          });
          await foodStore.add(database, {
            "foodName": "Chicken",
            "foodType": "Raw food",
            "foodImage":"assets/images/food/chicken.jpg",
            "foodInfo":"Cooked chicken is a healthy food that is safe for most dogs to eat.\nChicken is one of the most common ingredients used in dog foods, as it is an excellent source of protein, which your dog needs to stay healthy. You can feed your dog chicken on its own or combine it with his regular food.\nIt is worth noting that you should always remove chicken from the bone before feeding it to your dog. Chicken bones pose a choking hazard and may puncture his digestive tract.\nAdditionally, it is important to avoid feeding your dog raw chicken to prevent a Salmonella infection.",
            "foodEdible":"Edible",
            "foodFor":"All kinds",
          });
          await foodStore.add(database, {
            "foodName": "Chocolate",
            "foodType": "Raw food",
            "foodImage":"assets/images/food/choco.jpg",
            "foodInfo":"It is widely known that dogs should never eat chocolate.\nThis is because chocolate contains theobromine and caffeine, two stimulants that dogs cannot efficiently metabolize.\nIf your dog eats chocolate, he may exhibit symptoms like vomiting, diarrhea and dehydration. These symptoms may lead to more serious complications, such as internal bleeding, muscle tremors, seizures and death.\nDarker and less sweet varieties of chocolate, such as cocoa powder and unsweetened baker’s chocolate, are more poisonous to dogs than sweetened varieties, such as milk chocolate.\nNevertheless, do not feed your dog any type of chocolate.",
            "foodEdible":"Inedible",
            "foodFor":"None",
          });
          await foodStore.add(database, {
            "foodName": "Corn",
            "foodType": "Raw food",
            "foodImage":"assets/images/food/corn.jpg",
            "foodInfo":"Dogs can eat corn in moderate amounts.\nCorn is a good source of some vitamins and minerals and common ingredient in many types of dog food. A tablespoon or two of corn per day is an appropriate serving size for dogs.\nAlthough plain, cooked corn kernels are safe for dogs, you should never feed your dog corn on the cob. The cob is a choking hazard and could lead to intestinal obstruction if consumed.",
            "foodEdible":"Edible",
            "foodFor":"All kinds",
          });
          await foodStore.add(database, {
            "foodName": "Egg",
            "foodType": "Raw food",
            "foodImage":"assets/images/food/eggs.jpg",
            "foodInfo":"Cooked eggs are perfectly safe and nutritious for dogs to eat.\nOne medium egg provides some of almost every vitamin and mineral, plus lots of protein. There are claims that eggs may also help relieve nausea in dogs, although there is no scientific evidence behind this claim.\nIt is important to note that you should avoid feeding raw eggs to your dog. While dogs typically do not get sick from eating raw eggs, bacteria, such as Salmonella, can spread from the dog to its human owners, increasing their risk of infection.",
            "foodEdible":"Edible",
            "foodFor":"All kinds",
          });
          await foodStore.add(database, {
            "foodName": "Garlic",
            "foodType": "Raw food",
            "foodImage":"assets/images/food/garlic.jpg",
            "foodInfo":"Garlic contains chemicals called thiosulfates, which are toxic to dogs. Thiosulfates may damage your dog’s red blood cells and lead to anemia. Garlic consumption may also lead to symptoms like vomiting and diarrhea in dogs.\nIn severe cases, dogs may need a blood transfusion if they consume high amounts of garlic. Thus, it is important to avoid feeding garlic to your dog, even in small amounts.",
            "foodEdible":"Inedible",
            "foodFor":"None",
          });
          await foodStore.add(database, {
            "foodName": "Grape",
            "foodType": "Raw food",
            "foodImage":"assets/images/food/grapes.jpg",
            "foodInfo":"You should never feed grapes or raisins to your dog.Grapes and raisins contain toxic compounds that are harmful to dogs. They have the potential to lead to rapid kidney failure and death.\nEven small amounts of grapes and raisins can make your dog sick, so it’s important to avoid giving them to your dog altogether.",
            "foodEdible":"Inedible",
            "foodFor":"None",
          });
          await foodStore.add(database, {
            "foodName": "Lemon",
            "foodType": "Raw food",
            "foodImage":"assets/images/food/lemons.jpg",
            "foodInfo":"Lemons and limes can be toxic to your dog.\nThis is because the skins of lemons and limes contain a substance called psoralen, which can cause dogs to have gastrointestinal symptoms like vomiting and diarrhea.\nIf very large amounts of psoralen are consumed by dogs, more severe symptoms, such as muscle tremors, difficulty walking, liver failure and death, can result.",
            "foodEdible":"Inedible",
            "foodFor":"None",
          });
          await foodStore.add(database, {
            "foodName": "Milk",
            "foodType": "Raw food",
            "foodImage":"assets/images/food/milk.jpg",
            "foodInfo":"You should prevent your dog from drinking too much milk.\nLactose intolerance is common in dogs, which may cause loose stools, gas, vomiting, stomach pain and diarrhea.\nSome dogs are able to tolerate small quantities of milk as an occasional treat, but they should not drink more than a few tablespoons of milk per day.",
            "foodEdible":"Limit",
            "foodFor":"All kinds",
          });
          await foodStore.add(database, {
            "foodName": "Mushroom",
            "foodType": "Raw food",
            "foodImage":"assets/images/food/mushroom.jpg",
            "foodInfo":"Store-bought mushrooms, such as portobello mushrooms, are safe for dogs to eat.\nHowever, only feed your dog plain mushrooms that have not been combined with extra ingredients, such as garlic and onions, that may have adverse effects in dogs.\nAdditionally, it is worth noting that some wild mushrooms are toxic to your dog and may cause mushroom poisoning.",
            "foodEdible":"Edible",
            "foodFor":"All kinds",
          });
          await foodStore.add(database, {
            "foodName": "Onion",
            "foodType": "Raw food",
            "foodImage":"assets/images/food/onion.jpg",
            "foodInfo":"You should never feed your dog onions.\nOnions contain N-propyl disulfide, a compound that is toxic to dogs. It can damage your dog’s red blood cells, reducing their ability to carry oxygen through the body. This often results in a condition called anemia.\nAnemia in dogs is characterized by a variety of symptoms, including lethargy, weakness, decreased appetite and fainting. In severe cases, dogs with anemia may need a blood transfusion.\nIt is important to note that all components and forms of onions are toxic to dogs, even the leaves, juice and processed powders, such as onion powder.",
            "foodEdible":"Inedible",
            "foodFor":"None",
          });
          await foodStore.add(database, {
            "foodName": "Pork",
            "foodType": "Raw food",
            "foodImage":"assets/images/food/pork.jpg",
            "foodInfo":"Cooked pork without added spices, seasonings or sauces is safe for dogs to eat.\nHowever, you should never feed your dog raw or undercooked pork to prevent a bacterial infection, which can make your dog sick.\nFurthermore, processed forms of pork, such as ham and bacon, should never be fed to dogs. They’re often extremely high in salt, which can be harmful to dogs.",
            "foodEdible":"Edible",
            "foodFor":"All kinds",
          });
          await foodStore.add(database, {
            "foodName": "Potato",
            "foodType": "Raw food",
            "foodImage":"assets/images/food/potato.jpg",
            "foodInfo":"Dogs can eat plain potatoes that have been cooked.\nHowever, you should never feed your dog raw potatoes. Raw potatoes contain solanine, a compound that is toxic to dogs. Cooking potatoes reduces their solanine levels.\nPotatoes should only be fed to dogs in small amounts, as their high carbohydrate content may cause dogs to gain weight if they eat them in large quantities.",
            "foodEdible":"Edible",
            "foodFor":"All kinds",
          });
          await foodStore.add(database, {
            "foodName": "Rice",
            "foodType": "Raw food",
            "foodImage":"assets/images/food/rice.jpg",
            "foodInfo":"Dogs can eat plain and cooked brown or white rice.\nRice is very easy for dogs to digest and may help relieve an upset stomach.\nYou can feed rice to your dog on its own or combined with a little bit of chicken or turkey for extra protein.",
            "foodEdible":"Edible",
            "foodFor":"All kinds",
          });
          await foodStore.add(database, {
            "foodName": "Salmon",
            "foodType": "Raw food",
            "foodImage":"assets/images/food/salmon.jpg",
            "foodInfo":"Cooked, boneless salmon is a safe and healthy food for your dog.\nSalmon is a great source of omega-3 fatty acids, which are known to reduce inflammation and may help keep your dog’s skin and fur healthy.\nHowever, you should avoid feeding raw salmon to your dog. It may contain a parasite that is known to cause salmon poisoning disease, which can be fatal.",
            "foodEdible":"Edible",
            "foodFor":"All kinds",
          });
          await foodStore.add(database, {
            "foodName": "Shrimp",
            "foodType": "Raw food",
            "foodImage":"assets/images/food/shrimp.jpg",
            "foodInfo":"You can feed plain, cooked shrimp to your dog.\nShrimp is a healthy treat for dogs, as it’s an excellent source of protein and provides a significant amount of vitamins and minerals.\nHowever, you should avoid feeding raw shrimp to your dog, as it may contain harmful bacteria that could make him sick. Always make sure to remove the shell from shrimp to prevent your dog from choking.",
            "foodEdible":"Edible",
            "foodFor":"All kinds",
          });
          await foodStore.add(database, {
            "foodName": "Tomato",
            "foodType": "Raw food",
            "foodImage":"assets/images/food/tomatoes.jpg",
            "foodInfo":"It’s okay to feed your dog tomatoes as an occasional treat, as long as they are ripe.\nGreen tomatoes, on the other hand, may contain small amounts of tomatine, a toxic glycoalkaloid. While green tomatoes are not toxic to people, anecdotal evidence suggests it may harm dogs.\nDogs that consume too much tomatine from tomatoes may experience nausea, an abnormal heart rate, muscle weakness and difficulty breathing.",
            "foodEdible":"Limit",
            "foodFor":"All kinds",
          });
          await foodStore.add(database, {
            "foodName": "Wellness Puppy Food",
            "foodType": "Formula food",
            "foodImage":"assets/images/food/fo1food.jpg",
            "foodInfo":"Wellness Puppy gets the bulk of its animal protein from fresh chicken and chicken meal. Our dry matter label analysis reveals the recipe contains 32% protein, 20% fat and 40% estimated carbs… which produces a fat-to-protein ratio of about 62%.\nAn exceptional formula. Contains just the right amount of calcium to make it safe for all puppy breeds. Highly recommended.",
            "foodEdible":"Edible",
            "foodFor":"Puppy",
          });
          await foodStore.add(database, {
            "foodName": "Purina Pro Plan",
            "foodType": "Formula food",
            "foodImage":"assets/images/food/fo3food.jpg",
            "foodInfo":"This Purina Pro Plan puppy product derives the bulk of its animal protein from from poultry by-product meal. Our dry matter label analysis reveals the recipe contains 32% protein, 20% fat and 40% estimated carbs… with a fat-to-protein ratio of about 64%.\nPro Plan is one of the brands most often mentioned when we interview veterinary professionals.\nWhat’s more… every Pro Plan product meets the strict guidelines recommended by the World Small Animal Veterinary Association.\nA top choice. Highly recommended.",
            "foodEdible":"Edible",
            "foodFor":"Puppy",
          });
          await foodStore.add(database, {
            "foodName": "Blue Buffalo",
            "foodType": "Formula food",
            "foodImage":"assets/images/food/fo2food.jpg",
            "foodInfo":"This Blue Buffalo puppy product derives the majority of its meat protein from fresh chicken and chicken meal. Our dry matter label analysis reveals the recipe contains 30% protein, 18% fat and 44% estimated carbs… creating a fat-to-protein ratio of about 59%.\nBlue Life Protection offers 4 puppy recipes. All are nutrient-balanced, affordable and easy to recommend.",
            "foodEdible":"Edible",
            "foodFor":"Puppy",
          });
          await foodStore.add(database, {
            "foodName": "Iams ProActive",
            "foodType": "Formula food",
            "foodImage":"assets/images/food/fo4food.jpg",
            "foodInfo":"Iams ProActive Health Smart Puppy takes the dominant share of its meat protein from fresh chicken and chicken by-product meal. Our dry matter label analysis reveals the recipe contains 32% protein, 19% fat and 40% estimated carbs… resulting in a fat-to-protein ratio of about 60%.\nA classic, grain-inclusive puppy option containing fish oil to help create a healthy coat and build strong joints. It’s easy on the wallet, too. Highly recommended.",
            "foodEdible":"Edible",
            "foodFor":"Puppy",
          });
          await foodStore.add(database, {
            "foodName": "Victor Pro Food",
            "foodType": "Formula food",
            "foodImage":"assets/images/food/fo5food.jpg",
            "foodInfo":"Victor Purpose Nutra Pro gets the largest portion of its animal protein from chicken meal and blood meal. Our dry matter label analysis reveals the recipe contains 42% protein, 20% fat and 31% estimated carbs… which produces a fat-to-protein ratio of about 47%.\nAn economical grain-inclusive option… ideal for those feeding either (or both) puppies and adults in the same home. Highly recommended.",
            "foodEdible":"Edible",
            "foodFor":"Puppy",
          });
          await foodStore.add(database, {
            "foodName": "Now Fresh Food",
            "foodType": "Formula food",
            "foodImage":"assets/images/food/fo2food2.jpg",
            "foodInfo":"Now Fresh Large Breed Adult contains balanced proteins and fats from turkey, salmon and duck. Contains antioxidants found in fruits and vegetables such as spinach, cranberries, pumpkin, blackberries, and carrots. Great for building a strong immune system to help fight disease.\nRecommended for dogs over 50 pounds and between 15 months and 5 years of age. Contains extra nutrients such as glucosamine and chondroitin for hip and joint care for larger breed dogs.",
            "foodEdible":"Edible",
            "foodFor":"Adult dog",
          });
          await foodStore.add(database, {
            "foodName": "Blue Buffalo Wild",
            "foodType": "Formula food",
            "foodImage":"assets/images/food/fo1food2.jpg",
            "foodInfo":"Blue Buffalo Wilderness Large Breed Chicken is a great option for those looking for higher protein and an optimal blend of calcium, phosphorus and essential vitamins to help keep bones strong.\nOmega-3 and 6 fatty acids found in fish meal and flaxseed ensure a healthy coat. An ideal blend of protein, fat and carbohydrates are also included to assist your large breed dog in keeping a healthy weight. Never any grains or gluten and no artificial colors, flavors or preservatives.",
            "foodEdible":"Edible",
            "foodFor":"Adult dog",
          });
          await foodStore.add(database, {
            "foodName": "Merrick Backcountry",
            "foodType": "Formula food",
            "foodImage":"assets/images/food/fo3food2.jpg",
            "foodInfo":"Merrick Backcountry Raw Infused Large Breed recipe contains added glucosamine and chondroitin to help support healthy hip and joint function, essential for large breed dogs. Omega fatty acids from salmon oil help ensure a healthy skin and coat.\nA unique raw-infused kibble recipe loaded with protein. Antioxidant-rich fruits and vegetables like sweet potatoes, apples and blueberries are also included to boost your dog’s immune system.",
            "foodEdible":"Edible",
            "foodFor":"Adult dog",
          });
          await foodStore.add(database, {
            "foodName": "Orijen Six Fish",
            "foodType": "Formula food",
            "foodImage":"assets/images/food/fo4food2.jpg",
            "foodInfo":"From its founding, Champion Petfoods, the fabled maker of Orijen, has always favored and touted a meat-based, “biologically appropriate” canine diet… a proven, balanced formula which makes this food a top choice for large breed dogs. Highly recommended.",
            "foodEdible":"Edible",
            "foodFor":"Adult dog",
          });
          await foodStore.add(database, {
            "foodName": "Eagle Pack Food",
            "foodType": "Formula food",
            "foodImage":"assets/images/food/fo5food2.jpg",
            "foodInfo":"Eagle Pack Adult Large and Giant Breed is specially formulated with the right amount of fat, protein and carbohydrates to help larger dogs maintain a healthy weight. Dual animal proteins also help provide lean muscle mass.\nThis formula contains no corn, wheat, or meat by-products of any kind and has no artificial colors, flavors or preservatives. Perfectly balanced nutrition for dogs over 50 pounds.",
            "foodEdible":"Edible",
            "foodFor":"Adult dog",
          });

          //Init data for train
          await trainStore.add(database, {
            "trainName":"Running",
            "trainImage":"assets/images/train/run.PNG",
            "trainInfo":"Running is a great form of exercise for some dogs. Not all dogs can tolerate this type of exercise, but some dogs simply can't get enough!\nRunning with your dog can be made easier when you use a hands-free leash. Off-leash running is not usually a good idea for safety and legal reasons. However, it may be considered if your dog has a truly reliable recall and local laws allow off-leash dogs.\nWhen you first begin running with your dog, make sure to start slowly and work your way up to higher speeds and longer distances. Avoid running in hot temperatures, especially on hot asphalt as it can burn paws. Check-in with your dog regularly to monitor his exercise tolerance and take breaks as needed. Bring plenty of water along on runs.",
            "trainFor":"Puppy and Adult dog",
          });
          await trainStore.add(database, {
            "trainName":"Walking",
            "trainImage":"assets/images/train/walk.PNG",
            "trainInfo":"Walking is the classic form of exercise we tend to give our dogs. But that's okay, most dogs love to walk!\nIn addition to getting some exercise, a walk is a great way for your dog to explore the world with her nose. Don't rush it. Let your dog her take the time to sniff around during the walk. Try to take a different route every so often so your dog will get to see and smell new things.",
            "trainFor":"Puppy and Adult dog",
          });
          await trainStore.add(database, {
            "trainName":"Cycling",
            "trainImage":"assets/images/train/cycle.PNG",
            "trainInfo":"Not every dog is built to run alongside your bike. This can be dangerous in some cases \(for you and your dog\). However, riding a bike with your dog can be fun if you do it right.\nThe most important thing is to start slowly. Let your dog get used to the bike. Next, let her acclimate to running and keeping up with you. Ride as slowly as possible at first and avoid a lot of twists and turns. Your dog should always be leashed, so you may want to find a good bicycle attachment so you won't have to hold your dog's leash.",
            "trainFor":"Adult dog",
          });
          await trainStore.add(database, {
            "trainName":"Hiking",
            "trainImage":"assets/images/train/hike.PNG",
            "trainInfo":"If you love nature and you love dogs, then hiking with your dog might be perfect for you. Hiking gives your dog a chance to explore the world on a deeper level than a simple walk.\nWhen you first begin hiking with your dog, start with short day hikes on a cooler day.\nAvoid difficult trails with a lot of rough terrain until your dog gets used to easy to moderate hikes and will be more sure-footed.\nBring plenty of water along. Your dog might even take her own backpack; just make sure it's well-balanced and not too heavy.",
            "trainFor":"Adult dog",
          });
          await trainStore.add(database, {
            "trainName":"Swimming",
            "trainImage":"assets/images/train/swim.PNG",
            "trainInfo":"Contrary to popular belief, not all dogs know how to swim. Other dogs simply don't like to swim. But if you have a water dog, you know it. Let that dog swim! You can incorporate the game of fetch with swimming to make it even more fun. Just remember these water safety tips.\nIf your dog doesn't mind the water but also cannot swim, you can still teach her. Start with a doggie lifejacket and shallow water until she gets the hang of it. If she likes the water, it won't be long before she is fine on her own. If she doesn't like the water, don't push it. She might just be a land lover.",
            "trainFor":"Adult dog",
          });
          await trainStore.add(database, {
            "trainName":"Jumping",
            "trainImage":"assets/images/train/jump.PNG",
            "trainInfo":"Jumping can place a lot of strain on your dog’s muscles and the joints, so it is important to begin training your dog when it is fully grown. Puppies and young dogs can more easily damage their developing bones and muscles while jumping.When your dog is fully grown. Training can be handled by these following steps:\n\nStep 1:\nBefore you begin training your dog to jump, decide what command or cue to use while training your dog. Select a word such as \“over\” or\“jump\” Use your chosen command or cue consistently throughout the training.\n\nStep 2:\nPlace your dog on a leash and bring it toward the jumping poles. If it seems hesitant about approaching this new fixture, allow it to sniff around the poles. This will help the dog become familiar with them and realize that they are not a threat.\n\nStep 3:\nPlace the pole on the lowest rung or directly on the ground. With your dog on a leash, bring your dog toward the jumping pole and have it walk over it. Say your command word as it steps, not jumps or hops over the pole. Bring your dog across several times and continue to repeat the command word. This will help the dog acclimate to the pole and the command word. Reward your dog with praise or a treat.\n\nStep 4:\nOnce your dog has successfully walked over the pole several times, make it a little more challenging by raising the pole to the next rung. Show the dog a treat and lead it to the pole. As it approaches, say your command word. After the dog jumps over, reward it with praise and give it the treat.\n\nStep 5:\nAs your dog becomes more comfortable jumping at a lower level, remove the leash and raise the bar little by little. Be sure that the jumping pole does not to exceed the height of your dog.\nRepeat it gradually and you will succeed in training your dog !",
            "trainFor":"Adult dog",
          });
          await trainStore.add(database, {
            "trainName":"Plate Retrieving",
            "trainImage":"assets/images/train/plate.jpg",
            "trainInfo":"Teaching your dog to come to you when you call him is an important command that can save your dog's life if he ever gets off his leash while you are out for a walk. Using the paper plate recall method is a fun training. Following these steps:\n\nStep 1:\nTell your dog to sit, then stay. Put a paper plate on the ground about 1 foot away from your dog and place a small dog treat on it. Tell your dog to go get it and let him eat the treat.\n\nStep 2:\nCall your pet back to you after he eats the treat. Use a short phrase like, \"Come here, boy!\" or simply \"Come!\" in an excited voice so your dog comes quickly and is ready to keep playing. Shorter commands are easier for dogs to understand.\n\nStep 3:\nChange the location of the paper plate each time you try the paper plate recall, gradually moving it farther away from you and your dog. Remember to tell your furry friend to stay each time before you walk away to put the plate down.\n\nStep 4:\nAdd a second paper plate after your pet is used to playing this training game with one plate. Put the two plates an equal distance from you and your dog in opposite directions. Tell your dog to go get the first treat, then call him back before sending him over to the second one.\n\nStep 5:\nVary the game after your pet is used to the two-plate drill. Put a plate behind him before sending him to the treat or call him back before he reaches the plate and give him a treat from your hand instead, if he listens.",
            "trainFor":"Puppy and Adult dog",
          });
          await trainStore.add(database, {
            "trainName":"Tug of War",
            "trainImage":"assets/images/train/tug.PNG",
            "trainInfo":"Training him to play tug of war is nice and easy. The main thing you need to do is get him excited about playing and motivate him to sink his teeth into a toy. Throw in some tasty treats to reward him and he’ll be wanting to play tug of war every day. If he’s a puppy and full of energy, this could take just a couple of days to teach him following these steps:\n\nStep 1:\nGetting set up Head to a quiet, large space with your toy, your dog, and some treats in your pocket. You’re going to use a verbal command to get the game going.\n\nStep 2:\nHold the toy in front of his mouth Play with it, dangle it, and encourage him to put his mouth or paws on it. It will also help if you’re on your knees at his height. If he’s not interested, pull a treat out to get him focused.\n\nStep 3:\n\‘Tug\’ As you encourage him to play, issue the \‘tug\’ verbal command. This will be the cue he will learn to associate with the behavior. Ensure you say it in a playful voice, he will pick it up quicker if the thinks it’s all a big game.\n\nStep 4:\nWait for contact As soon as he touches the toy with his mouth, give him a treat and praise. It’s important you reward any signs of interest in the toy to start with. As he gets the hang of it, you can begin to play properly.\n\nStep 5:\nConsistency and difficulty Repeat this process, but don’t give him the treat until he shows more of an interest in the toy this time. Keep repeating this until he finally starts to properly pull on it. Then give him a treat only when he’s really played tug of war for 30 seconds. It may take a few days, but when he’s got the hang of it, you can cut down on the frequency of treats. The verbal cue alone at this point will be enough to signal to him what you want him to do.",
            "trainFor":"Puppy and Adult dog",
          });
          await trainStore.add(database, {
            "trainName":"Tracking",
            "trainImage":"assets/images/train/tracking.jpg",
            "trainInfo":"Once your dog has mastered \“sit\” and \“stay\,” you may be tempted to start working on more advanced training techniques to work on with your pupper. Since dogs have an impeccable sense of smell, working with your dog to track by scent only makes sense.\n\nStep 1:\nTo teach scenting a track, you need some treats and a grassy area, such as a baseball field or park. Although hot dogs are not the most nutritious food, I find they work best, and you won’t over stuff your dog’s belly. Begin early; many people start by 6 a.m. before anyone has walked on the grass.\n\nStep 2:\nHave your dog sit or lie down and stay. Take a couple of inch-long pieces of hot dog and use your shoe to mash them into the grass. Make sure to crush the grass under the hot dogs, which will release a grass scent. Then, with the hot dog residue on the bottom of your shoe, walk a straight line away from your dog. Every six or ten feet, drop a piece of hot dog. Stop after about 20 feet and drop one of your gloves or one of your dog’s toys; your dog needs to find something at the end of the track. Drop another piece of hot dog on top of the item.\n\nStep 3:\nGo back to your dog and release him from his stay, encouraging him to smell the ground where the hot dogs were. Tell your dog \“Find it!\” and let him sniff. If he begins to follow the track, praise him quietly by saying, \“Good dog!\” and let him lead the way. Don’t be too enthusiastic or you may distract the dog from his sniffing. Also, don’t try to lead him; let your dog figure it out.\n\nStep 4:\nWhen your dog successfully completes this trick, make another one by taking 10 steps to the side. If your dog is excited and having fun, you can do three or four short tracks per training session. As your dog improves over several sessions, make the track longer, add curves and corners, and drop several items along the way, but put the hot dog only on the one you want him to find. When making tracks longer or adding curves, use small pegs, stakes or flags to mark the track so you can tell if your dog is off track.",
            "trainFor":"Adult dog",
          });

          //Init data for BMI
          await bmiStore.add(database,{
            "dogName":"Akita",
            "gender":"male",
            "underWeight":99,
            "overWeight":114,
          });
          await bmiStore.add(database,{
            "dogName":"Akita",
            "gender":"female",
            "underWeight":92,
            "overWeight":114,
          });
          await bmiStore.add(database,{
            "dogName":"American Staffordshire",
            "gender":"male",
            "underWeight":130,
            "overWeight":139,
          });
          await bmiStore.add(database,{
            "dogName":"American Staffordshire",
            "gender":"female",
            "underWeight":145,
            "overWeight":156,
          });
          await bmiStore.add(database,{
            "dogName":"Basset Hound",
            "gender":"male",
            "underWeight":146,
            "overWeight":203,
          });
          await bmiStore.add(database,{
            "dogName":"Basset Hound",
            "gender":"female",
            "underWeight":78,
            "overWeight":171,
          });
          await bmiStore.add(database,{
            "dogName":"Beagle",
            "gender":"male",
            "underWeight":75,
            "overWeight":85,
          });
          await bmiStore.add(database,{
            "dogName":"Beagle",
            "gender":"female",
            "underWeight":75,
            "overWeight":85,
          });
          await bmiStore.add(database,{
            "dogName":"Bichon Frise",
            "gender":"male",
            "underWeight":58,
            "overWeight":61,
          });
          await bmiStore.add(database,{
            "dogName":"Bichon Frise",
            "gender":"female",
            "underWeight":61,
            "overWeight":69,
          });
          await bmiStore.add(database,{
            "dogName":"Border Collie",
            "gender":"male",
            "underWeight":59,
            "overWeight":64,
          });
          await bmiStore.add(database,{
            "dogName":"Border Collie",
            "gender":"female",
            "underWeight":54,
            "overWeight":59,
          });
          await bmiStore.add(database,{
            "dogName":"Boston Terrier",
            "gender":"male",
            "underWeight":31,
            "overWeight":60,
          });
          await bmiStore.add(database,{
            "dogName":"Boston Terrier",
            "gender":"female",
            "underWeight":31,
            "overWeight":61,
          });
          await bmiStore.add(database,{
            "dogName":"Bulldog",
            "gender":"male",
            "underWeight":123,
            "overWeight":128,
          });
          await bmiStore.add(database,{
            "dogName":"Bulldog",
            "gender":"female",
            "underWeight":122,
            "overWeight":125,
          });
          await bmiStore.add(database,{
            "dogName":"Chihuahua",
            "gender":"male",
            "underWeight":39,
            "overWeight":52,
          });
          await bmiStore.add(database,{
            "dogName":"Chihuahua",
            "gender":"female",
            "underWeight":39,
            "overWeight":52,
          });
          await bmiStore.add(database,{
            "dogName":"Chow Chow",
            "gender":"male",
            "underWeight":97,
            "overWeight":102,
          });
          await bmiStore.add(database,{
            "dogName":"Chow Chow",
            "gender":"female",
            "underWeight":97,
            "overWeight":102,
          });
          await bmiStore.add(database,{
            "dogName":"Dachshund",
            "gender":"male",
            "underWeight":32,
            "overWeight":43,
          });
          await bmiStore.add(database,{
            "dogName":"Dachshund",
            "gender":"female",
            "underWeight":32,
            "overWeight":43,
          });
          await bmiStore.add(database,{
            "dogName":"Dobermann",
            "gender":"male",
            "underWeight":68,
            "overWeight":89,
          });
          await bmiStore.add(database,{
            "dogName":"Dobermann",
            "gender":"female",
            "underWeight":80,
            "overWeight":95,
          });
          await bmiStore.add(database,{
            "dogName":"English Mastiff",
            "gender":"male",
            "underWeight":151,
            "overWeight":258,
          });
          await bmiStore.add(database,{
            "dogName":"English Mastiff",
            "gender":"female",
            "underWeight":140,
            "overWeight":240,
          });
          await bmiStore.add(database,{
            "dogName":"German Shepherd",
            "gender":"male",
            "underWeight":78,
            "overWeight":116,
          });
          await bmiStore.add(database,{
            "dogName":"German Shepherd",
            "gender":"female",
            "underWeight":92,
            "overWeight":138,
          });
          await bmiStore.add(database,{
            "dogName":"Golden Retriever",
            "gender":"male",
            "underWeight":86,
            "overWeight":91,
          });
          await bmiStore.add(database,{
            "dogName":"Golden Retriever",
            "gender":"female",
            "underWeight":79,
            "overWeight":86,
          });
          await bmiStore.add(database,{
            "dogName":"Great Dane",
            "gender":"male",
            "underWeight":92,
            "overWeight":95,
          });
          await bmiStore.add(database,{
            "dogName":"Great Dane",
            "gender":"female",
            "underWeight":90,
            "overWeight":94,
          });
          await bmiStore.add(database,{
            "dogName":"Labrador Retriever",
            "gender":"male",
            "underWeight":90,
            "overWeight":111,
          });
          await bmiStore.add(database,{
            "dogName":"Labrador Retriever",
            "gender":"female",
            "underWeight":91,
            "overWeight":106,
          });
          await bmiStore.add(database,{
            "dogName":"Maltese Dog",
            "gender":"male",
            "underWeight":35,
            "overWeight":49,
          });
          await bmiStore.add(database,{
            "dogName":"Maltese Dog",
            "gender":"female",
            "underWeight":35,
            "overWeight":49,
          });
          await bmiStore.add(database,{
            "dogName":"Pomeranian",
            "gender":"male",
            "underWeight":34,
            "overWeight":43,
          });
          await bmiStore.add(database,{
            "dogName":"Pomeranian",
            "gender":"female",
            "underWeight":34,
            "overWeight":43,
          });
          await bmiStore.add(database,{
            "dogName":"Poodle",
            "gender":"male",
            "underWeight":70,
            "overWeight":79,
          });
          await bmiStore.add(database,{
            "dogName":"Poodle",
            "gender":"female",
            "underWeight":84,
            "overWeight":88,
          });
          await bmiStore.add(database,{
            "dogName":"Pug",
            "gender":"male",
            "underWeight":64,
            "overWeight":68,
          });
          await bmiStore.add(database,{
            "dogName":"Pug",
            "gender":"female",
            "underWeight":87,
            "overWeight":98,
          });
          await bmiStore.add(database,{
            "dogName":"Rottweiler",
            "gender":"male",
            "underWeight":115,
            "overWeight":125,
          });
          await bmiStore.add(database,{
            "dogName":"Rottweiler",
            "gender":"female",
            "underWeight":123,
            "overWeight":134,
          });
          await bmiStore.add(database,{
            "dogName":"Shih Tzu",
            "gender":"male",
            "underWeight":63,
            "overWeight":92,
          });
          await bmiStore.add(database,{
            "dogName":"Shih Tzu",
            "gender":"female",
            "underWeight":63,
            "overWeight":92,
          });
          await bmiStore.add(database,{
            "dogName":"Siberian Husky",
            "gender":"male",
            "underWeight":56,
            "overWeight":73,
          });
          await bmiStore.add(database,{
            "dogName":"Siberian Husky",
            "gender":"female",
            "underWeight":61,
            "overWeight":72,
          });
          await bmiStore.add(database,{
            "dogName":"Yorkshire Terrier",
            "gender":"male",
            "underWeight":50,
            "overWeight":93,
          });
          await bmiStore.add(database,{
            "dogName":"Yorkshire Terrier",
            "gender":"female",
            "underWeight":50,
            "overWeight":83,
          });
        }
      }
    );
    GetIt.I.registerSingleton<Database>(database);
  }
}