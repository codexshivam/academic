/* Last updated on October 27, 2025 11:45 PM IST
Logical Thinking & Problem Solving (Semester 1, 2025-2026)

This script is a command-line C program that acts as a personal vault, letting you store and search academic terms by subject and securely manage your private passwords and secrets.*/

#include <stdio.h>
#include <string.h> 

#define MAX_SUBJECTS 50        
#define MAX_TERMS_PER_SUBJECT 500 
#define MAX_SECRETS 500
#define MAX_STRLEN 500         

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

void clearInputBuffer() {
    int c;
    while ((c = getchar()) != '\n' && c != EOF);
}

void readString(char* buffer, int length) {
    fgets(buffer, length, stdin);
    buffer[strcspn(buffer, "\n")] = 0;
}

void addSubject() {
    printf("\n--- Add New Subject ---\n");
    if (subject_count >= MAX_SUBJECTS) {
        printf("Error: Maximum number of subjects (%d) reached.\n", MAX_SUBJECTS);
        return;
    }

    printf("Enter new subject name: ");
    readString(all_subjects[subject_count].name, MAX_STRLEN);

    all_subjects[subject_count].term_count = 0;
    
    printf("Subject '%s' added successfully.\n", all_subjects[subject_count].name);
    subject_count++; 
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
    printf("\n--- Add New Term ---\n");
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
}

void searchTerm() {
    printf("\n--- Search for Term (Exact Match) ---\n");
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
    printf("\n--- Full-Text Search (All Subjects) ---\n");
    
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
    printf("\n--- Full Dictionary ---\n");
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
    printf("\n--- Add New Secret ---\n");
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
}

void searchSecrets() {
    printf("\n--- Search Secrets ---\n");
    
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

    do {
        printf("\n--- Subject-Based Dictionary ---\n");
        printf("1. Add New Subject\n");
        printf("2. Add New Term (to a Subject)\n");
        printf("3. Search for Term in Specific Subject\n");
        printf("4. Search (All Subjects)\n");
        printf("5. View All Subjects and Terms\n");
        printf("--- Passwords & Secrets Manager ---\n");
        printf("6. Add New Password/Secret\n");
        printf("7. Search Passwords & Secrets\n");
        printf("8. Exit\n");
        printf("----------------------------------\n");
        printf("Enter your choice: ");

        scanf("%d", &choice);
        clearInputBuffer(); 

        switch (choice) {
            case 1:
                addSubject();
                break;
            case 2:
                addTerm();
                break;
            case 3:
                searchTerm();
                break;
            case 4:
                fullTextSearch();
                break;
            case 5:
                viewAll();
                break;
            case 6:
                addSecret();
                break;
            case 7:
                searchSecrets();
                break;
            case 8:
                printf("Goodbye!\n");
                break;
            default:
                printf("Invalid choice. Please enter a number between 1 and 8.\n");
        }
    } while (choice != 8);

    return 0;
}
