/* Last updated on November 06, 2025 01:53 AM IST
Logical Thinking & Problem Solving (Semester 1, 2025-2026)
*/

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define MAX_SUBJECTS 10
#define MAX_TERMS_PER_SUBJECT 20
#define MAX_SECRETS 50
#define MAX_STRLEN 200

#define SUBJECT_FILE "subjects.txt"
#define SECRET_FILE "secrets.txt"

struct Term {
    char name[MAX_STRLEN];
    char definition[MAX_STRLEN];
};

struct Subject {
    char name[MAX_STRLEN];
    struct Term terms[MAX_TERMS_PER_SUBJECT];
    int term_count;
};

struct Secret {
    char service[MAX_STRLEN];
    char username[MAX_STRLEN];
    char secret_key[MAX_STRLEN];
};

struct Subject all_subjects[MAX_SUBJECTS];
int subject_count = 0;

struct Secret all_secrets[MAX_SECRETS];
int secret_count = 0;

void clearScreen() {
    #ifdef _WIN32
        system("cls");
    #else
        system("clear");
    #endif
}

void pressEnterToContinue() {
    printf("\nPress Enter to continue...");
    int c;
    while ((c = getchar()) != '\n' && c != EOF);
}

void printHeader(const char* title) {
    clearScreen();
    printf("\n==========================================\n");
    printf("          CLI VAULT - %s\n", title);
    printf("==========================================\n\n");
}

void stripNewline(char *buffer) {
    buffer[strcspn(buffer, "\n")] = 0;
}

void saveSubjects() {
    FILE *file = fopen(SUBJECT_FILE, "w");
    if (file == NULL) {
        printf("Error: Could not open file %s for saving.\n", SUBJECT_FILE);
        return;
    }

    fprintf(file, "%d\n", subject_count);

    for (int i = 0; i < subject_count; i++) {
        fprintf(file, "%s\n", all_subjects[i].name);
        fprintf(file, "%d\n", all_subjects[i].term_count);

        for (int j = 0; j < all_subjects[i].term_count; j++) {
            fprintf(file, "%s\n", all_subjects[i].terms[j].name);
            fprintf(file, "%s\n", all_subjects[i].terms[j].definition);
        }
    }
    fclose(file);
}

void loadSubjects() {
    FILE *file = fopen(SUBJECT_FILE, "r");
    if (file == NULL) {
        subject_count = 0;
        return;
    }

    char buffer[MAX_STRLEN];

    if (fgets(buffer, MAX_STRLEN, file) == NULL) {
        fclose(file);
        return;
    }
    sscanf(buffer, "%d", &subject_count);

    if (subject_count > MAX_SUBJECTS) subject_count = MAX_SUBJECTS;

    for (int i = 0; i < subject_count; i++) {
        if (fgets(all_subjects[i].name, MAX_STRLEN, file) == NULL) break;
        stripNewline(all_subjects[i].name);

        if (fgets(buffer, MAX_STRLEN, file) == NULL) break;
        sscanf(buffer, "%d", &all_subjects[i].term_count);

        if (all_subjects[i].term_count > MAX_TERMS_PER_SUBJECT) {
            all_subjects[i].term_count = MAX_TERMS_PER_SUBJECT;
        }

        for (int j = 0; j < all_subjects[i].term_count; j++) {
            if (fgets(all_subjects[i].terms[j].name, MAX_STRLEN, file) == NULL) break;
            stripNewline(all_subjects[i].terms[j].name);
            
            if (fgets(all_subjects[i].terms[j].definition, MAX_STRLEN, file) == NULL) break;
            stripNewline(all_subjects[i].terms[j].definition);
        }
    }
    fclose(file);
}

void saveSecrets() {
    FILE *file = fopen(SECRET_FILE, "w");
    if (file == NULL) {
        printf("Error: Could not open file %s for saving.\n", SECRET_FILE);
        return;
    }

    fprintf(file, "%d\n", secret_count);

    for (int i = 0; i < secret_count; i++) {
        fprintf(file, "%s\n", all_secrets[i].service);
        fprintf(file, "%s\n", all_secrets[i].username);
        fprintf(file, "%s\n", all_secrets[i].secret_key);
    }
    fclose(file);
}

void loadSecrets() {
    FILE *file = fopen(SECRET_FILE, "r");
    if (file == NULL) {
        secret_count = 0;
        return;
    }

    char buffer[MAX_STRLEN];

    if (fgets(buffer, MAX_STRLEN, file) == NULL) {
        fclose(file);
        return;
    }
    sscanf(buffer, "%d", &secret_count);

    if (secret_count > MAX_SECRETS) secret_count = MAX_SECRETS;

    for (int i = 0; i < secret_count; i++) {
        if (fgets(all_secrets[i].service, MAX_STRLEN, file) == NULL) break;
        stripNewline(all_secrets[i].service);

        if (fgets(all_secrets[i].username, MAX_STRLEN, file) == NULL) break;
        stripNewline(all_secrets[i].username);

        if (fgets(all_secrets[i].secret_key, MAX_STRLEN, file) == NULL) break;
        stripNewline(all_secrets[i].secret_key);
    }
    fclose(file);
}

void clearInputBuffer() {
    int c;
    while ((c = getchar()) != '\n' && c != EOF);
}

void readString(char* buffer, int length) {
    fgets(buffer, length, stdin);
    stripNewline(buffer);
}

void addSubject() {
    printHeader("Add New Subject");
    if (subject_count >= MAX_SUBJECTS) {
        printf("Error: Maximum number of subjects (%d) reached.\n", MAX_SUBJECTS);
        return;
    }

    printf("Enter new subject name: ");
    readString(all_subjects[subject_count].name, MAX_STRLEN);

    all_subjects[subject_count].term_count = 0;
    
    printf("Subject '%s' added successfully.\n", all_subjects[subject_count].name);
    subject_count++;
    saveSubjects();
}

int selectSubject() {
    if (subject_count == 0) {
        printf("Error: No subjects added yet. Please add a subject first.\n");
        return -1;
    }

    printf("Available Subjects:\n");
    for (int i = 0; i < subject_count; i++) {
        printf("  %d. %s\n", i + 1, all_subjects[i].name);
    }

    int choice;
    printf("Select a subject (1-%d): ", subject_count);
    scanf("%d", &choice);
    clearInputBuffer();

    if (choice < 1 || choice > subject_count) {
        printf("Invalid selection.\n");
        return -1;
    }
    
    return choice - 1;
}

void addTerm() {
    printHeader("Add New Term");
    int subject_index = selectSubject();

    if (subject_index == -1) {
        return;
    }

    struct Subject* selected_subject = &all_subjects[subject_index];

    if (selected_subject->term_count >= MAX_TERMS_PER_SUBJECT) {
        printf("Error: Max terms (%d) reached for this subject.\n", MAX_TERMS_PER_SUBJECT);
        return;
    }
    
    struct Term* new_term = &selected_subject->terms[selected_subject->term_count];

    printf("Enter term name: ");
    readString(new_term->name, MAX_STRLEN);

    printf("Enter definition: ");
    readString(new_term->definition, MAX_STRLEN);

    selected_subject->term_count++;
    
    printf("Term '%s' added to '%s'.\n", new_term->name, selected_subject->name);
    saveSubjects();
}

void searchTerm() {
    printHeader("Search in Subject");
    int subject_index = selectSubject();

    if (subject_index == -1) {
        return;
    }

    struct Subject* selected_subject = &all_subjects[subject_index];

    if (selected_subject->term_count == 0) {
        printf("This subject has no terms yet.\n");
        return;
    }

    char search_term_name[MAX_STRLEN];
    printf("Enter term to search for: ");
    readString(search_term_name, MAX_STRLEN);

    for (int i = 0; i < selected_subject->term_count; i++) {
        if (strcmp(search_term_name, selected_subject->terms[i].name) == 0) {
            printf("\n--- Match Found ---\n");
            printf("Subject: %s\n", selected_subject->name);
            printf("Term: %s\n", selected_subject->terms[i].name);
            printf("Definition: %s\n", selected_subject->terms[i].definition);
            return;
        }
    }

    printf("Sorry, term '%s' not found in '%s'.\n", search_term_name, selected_subject->name);
}

void fullTextSearch() {
    printHeader("Full-Text Search");
    
    if (subject_count == 0) {
        printf("Dictionary is empty. Add a subject first.\n");
        return;
    }

    char keyword[MAX_STRLEN];
    printf("Enter keyword to search for: ");
    readString(keyword, MAX_STRLEN);

    int matches_found = 0;
    printf("\nSearching for '%s'...\n", keyword);

    for (int i = 0; i < subject_count; i++) {
        struct Subject* s = &all_subjects[i];

        for (int j = 0; j < s->term_count; j++) {
            struct Term* t = &s->terms[j];

            if (strstr(t->name, keyword) != NULL || strstr(t->definition, keyword) != NULL) {
                printf("\n--- Match Found ---\n");
                printf("Subject: %s\n", s->name);
                printf("Term: %s\n", t->name);
                printf("Definition: %s\n", t->definition);
                matches_found++;
            }
        }
    }

    if (matches_found == 0) {
        printf("\nNo matches found for '%s' anywhere in the dictionary.\n", keyword);
    } else {
        printf("\nFound %d match(es).\n", matches_found);
    }
}


void viewAll() {
    printHeader("Full Dictionary");
    if (subject_count == 0) {
        printf("Dictionary is empty. Add a subject first.\n");
        return;
    }

    for (int i = 0; i < subject_count; i++) {
        struct Subject* s = &all_subjects[i];
        printf("\n============================\n");
        printf("Subject: %s\n", s->name);
        printf("============================\n");

        if (s->term_count == 0) {
            printf("  (No terms added for this subject)\n");
        } else {
            for (int j = 0; j < s->term_count; j++) {
                struct Term* t = &s->terms[j];
                printf("  Term: %s\n", t->name);
                printf("  Def: %s\n\n", t->definition);
            }
        }
    }
}

void addSecret() {
    printHeader("Add New Secret");
    if (secret_count >= MAX_SECRETS) {
        printf("Error: Maximum number of secrets (%d) reached.\n", MAX_SECRETS);
        return;
    }

    struct Secret* new_secret = &all_secrets[secret_count];

    printf("Enter service name (e.g., 'Email', 'GitHub'): ");
    readString(new_secret->service, MAX_STRLEN);

    printf("Enter username (or email): ");
    readString(new_secret->username, MAX_STRLEN);

    printf("Enter secret key (or password): ");
    readString(new_secret->secret_key, MAX_STRLEN);

    secret_count++;
    printf("Secret for '%s' added successfully.\n", new_secret->service);
    saveSecrets();
}

void searchSecrets() {
    printHeader("Search Secrets");
    
    if (secret_count == 0) {
        printf("No secrets saved yet.\n");
        return;
    }

    char keyword[MAX_STRLEN];
    printf("Enter keyword to search (by Service or Username): ");
    readString(keyword, MAX_STRLEN);

    int matches_found = 0;
    printf("\nSearching for '%s'...\n", keyword);

    for (int i = 0; i < secret_count; i++) {
        struct Secret* s = &all_secrets[i];

        if (strstr(s->service, keyword) != NULL || strstr(s->username, keyword) != NULL) {
            printf("\n--- Match Found ---\n");
            printf("Service: %s\n", s->service);
            printf("Username: %s\n", s->username);
            printf("(Secret is hidden for security)\n");
            matches_found++;
        }
    }

    if (matches_found == 0) {
        printf("\nNo matches found for '%s'.\n", keyword);
    } else {
        printf("\nFound %d match(es).\n", matches_found);
        
        char service_name[MAX_STRLEN];
        printf("\nType the EXACT Service name to view its secret (or 'q' to cancel): ");
        readString(service_name, MAX_STRLEN);

        if (strcmp(service_name, "q") == 0 || strcmp(service_name, "") == 0) {
            printf("Cancelled.\n");
            return;
        }

        int found = 0;
        for (int i = 0; i < secret_count; i++) {
            if (strcmp(all_secrets[i].service, service_name) == 0) {
                printf("\n--- Secret for '%s' ---\n", all_secrets[i].service);
                printf("Secret Key: %s\n", all_secrets[i].secret_key);
                found = 1;
                break;
            }
        }
        if (!found) {
            printf("No service with that exact name found.\n");
        }
    }
}

int main() {
    int choice;

    loadSubjects();
    loadSecrets();

    do {
        clearScreen();
        printf("\n==================================\n");
        printf("          CLI VAULT MAIN MENU\n");
        printf("==================================\n");
        printf("  1. Add New Subject\n");
        printf("  2. Add New Term\n");
        printf("  3. Search in Subject\n");
        printf("  4. Full-Text Search\n");
        printf("  5. View All Subjects & Terms\n");
        printf("  6. Add New Password/Secret\n");
        printf("  7. Search Passwords & Secrets\n");
        printf("  8. Exit\n");
        printf("----------------------------------\n");
        printf("Enter your choice: ");

        if (scanf("%d", &choice) != 1) {
            choice = -1;
        }
        clearInputBuffer();

        switch (choice) {
            case 1:
                addSubject();
                pressEnterToContinue();
                break;
            case 2:
                addTerm();
                pressEnterToContinue();
                break;
            case 3:
                searchTerm();
                pressEnterToContinue();
                break;
            case 4:
                fullTextSearch();
                pressEnterToContinue();
                break;
            case 5:
                viewAll();
                pressEnterToContinue();
                break;
            case 6:
                addSecret();
                pressEnterToContinue();
                break;
            case 7:
                searchSecrets();
                pressEnterToContinue();
                break;
            case 8:
                printf("\nGoodbye!\n");
                break;
            default:
                printf("Invalid choice. Please enter a number between 1 and 8.\n");
                pressEnterToContinue();
        }
    } while (choice != 8);

    return 0;
}