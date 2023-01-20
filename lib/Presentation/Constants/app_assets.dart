import '../../Data/Models/AboutUsModel.dart';
import '../../Data/Models/ContactUsModel.dart';

///App logo image
const String sosLogoImage = 'assets/images/logo.png';

/// App SVG Icons
const String appointmentIconSVG = "assets/icons/appointment.svg";
const String articlesIconSVG = "assets/icons/articles.svg";
const String chatIconSVG = "assets/icons/chat.svg";
const String communityIconSVG = "assets/icons/community.svg";
const String defaultProfileIconSVG = "assets/icons/default-profile.svg";
const String detectIconSVG = "assets/icons/Detect.svg";
const String doctorsIconSVG = "assets/icons/doctors.svg";
const String hospitalIconSVG = "assets/icons/hospital.svg";
const String notificationIconSVG = "assets/icons/notification.svg";
const String profileIconSVG = "assets/icons/profile.svg";
const String settingsIconSVG = "assets/icons/settings.svg";
const String orangecircle = 'assets/images/orangecircle.png';

/// Privacy and Policies List

List<String> PrivacyAndPoliciesList = [
  "1. Violation of this Terms and Conditions or any other policies or instructions created for this service.",
  "2. User account closure request for services and / or LINKdotNET account.",
  "3. An inquiry and / or an order / issued by any authority / agency authorized by law.",
  "4. Issues or unforeseen technical or safety problems.",
  "5. User involvement in fraudulent or illegal activities.",
  "6. Paying for the services that the user owes LINKdotNET."
];

/// About US List

List<AboutUSModel> AboutUSList = [
  AboutUSModel(
      id: 1,
      question: "Who are we?",
      answer:
          "Students at Computer Science and Artificial Intelligence Helwan"),
  AboutUSModel(
      id: 2,
      question: "What is Save Your Skin?",
      answer:
          "Save Your Skin is an Emergancy Application to help detecting burn humans degree."),
  AboutUSModel(
      id: 3,
      question: "What exactly does SOS service provide??",
      answer:
          "It provides the ability to know the degree of burn to people with burns and appropriate treatment if the burn is minor, and also provides the ability to communicate with the nearest doctor or hospital for burn treatment."),
];

/// Contact Us List

List<ContactUSModel> ContactUsList = [
  ContactUSModel(
      question: "Contact Us", answer: "Email: SOS_SaveYourSkin@gmail.com"),
];
