#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <ctype.h>
#include <stdbool.h>
#define PACKET_SIZE 32


void trim(char **str) {
    size_t len = 0;
    char *frontp = *str;
    char *endp = NULL;

    if (*str == NULL) { return; }
    if ((*str)[0] == '\0') { return; }

    len = strlen(*str);
    endp = *str + len;

    /* Move the front and back pointers to address the first non-whitespace
     * characters from each end.
     */
    while (isspace((unsigned char) *frontp)) { ++frontp; }
    if (endp != frontp) {
        while (isspace((unsigned char) *(--endp)) && endp != frontp) {}
    }

    if (frontp != *str && endp == frontp)
        **str = '\0';
    else if (*str + len - 1 != endp)
        *(endp + 1) = '\0';

    /* Shift the string so that it starts at str so that if it's dynamically
     * allocated, we can still free it on the returned pointer.  Note the reuse
     * of endp to mean the front of the string buffer now.
     */
    endp = *str;
    if (frontp != *str) {
        while (*frontp) { *endp++ = *frontp++; }
        *endp = '\0';
    }
}


void modifyText(char **text)
{
    char *originalText = *text;
    int len = strlen(originalText);
    //char *newText = (char *)malloc((len * 2 + 1) * sizeof(char)); // Maximum possible length, each character might need to be doubled
    char *newText = (char *)malloc((len * 3 + 1) * sizeof(char)); // Maximum possible length, each character might need to be trippled ^^!

    if (newText == NULL)
    {
        fprintf(stdout, "Allocation failed");//TODO stderr
        return;
    }

    int j = 0;
    for (int i = 0; i < len; i++)
    {
        switch (originalText[i])
        {
        case '^':
        case '&':
        case '|':
        case '<':
        case '>':
        case '"':
        case '(':
        case ')':
            newText[j++] = '^';
            break;
        case '%':
            newText[j++] = originalText[i];
            break;
        case '!':
            newText[j++] = '^';
            newText[j++] = '^';
            break;

        }
        newText[j++] = originalText[i];
    }
    newText[j] = '\0'; // Null terminator added here

    *text = realloc(*text, (strlen(newText) + 1) * sizeof(char)); // Null terminator added here
    strcpy(*text, newText);
    //free(originalText);
    free(newText);
}


bool containsOnlyWhiteSpace(const char* str) {
    while (*str) {
        if (*str != ' ') {
            return false;
        }
        str++;
    }
    return true;
}



void printingTemplate(char **text, const char *fileName) {
    if (**text == '\0') {
        *text = malloc(strlen("@(Echo. )") + 1);
       if (*text == NULL) {
            fprintf(stdout, "Allocation failed!"); // TODO stderr
            return;
        }
        strcpy(*text, "@(Echo. )");
        return;
    }else if (**text == ' ') {
        if (containsOnlyWhiteSpace(*text)) {
             *text = malloc(strlen("@(Echo. )") + 1);
       if (*text == NULL) {
            fprintf(stdout, "Allocation failed!"); // TODO stderr
            return;
        }
        strcpy(*text, "@(Echo. )");
        return;
        } else {
           //if not only whitespace skip so empty
        }
    }

    char prefix[] = "@(Echo ";
    char suffix[] = " )>>";

    int newLength = strlen(prefix) + strlen(*text) + strlen(suffix) + strlen(fileName) + 2;
    char *oText = malloc(newLength * sizeof(char));
    if (oText == NULL) {
        fprintf(stdout, "Allocation failed!"); // TODO stderr
        return;
    }

    strcpy(oText, prefix);
    strcat(oText, *text);
    strcat(oText, suffix);
    strcat(oText, fileName);
    strcat(oText, "\n");

    *text = realloc(*text, strlen(oText) + 1); // No need for +2 here
    if (*text == NULL) {
        fprintf(stdout, "Reallocation failed!"); // TODO stderr
        free(oText); // Free oText before returning
        return;
    }

    strcpy(*text, oText);
    free(oText); // Free oText after using it
}



char *readLine(FILE *file) {
    int packetCount = 0;
    int packetCapacity = PACKET_SIZE;
    char *line = (char *)malloc(sizeof(char) * packetCapacity);
    int lineIndex = 0;

    if (line == NULL) {
        fprintf(stderr, "Failed to allocate memory.");
        exit(EXIT_FAILURE);
    }

    int c;
    while ((c = fgetc(file)) != EOF && c != '\n') {
        if (lineIndex == packetCapacity) {
            //printf("realloc");
            packetCount++;
            packetCapacity += PACKET_SIZE;
            line = (char *)realloc(line, sizeof(char) * packetCapacity);
            if (line == NULL) {
                fprintf(stderr, "Failed to reallocate memory.");
                exit(EXIT_FAILURE);
            }
        }
        line[lineIndex++] = (char)c;
    }

    if (c == EOF && lineIndex == 0) {
        free(line);
        return NULL;
    }

    line[lineIndex] = '\0';  // Null-terminate the string

    return line;
}




int main(int argc, char *argv[]) {
    if (argc < 3 || argc > 4) {
        printf("Usage: program.exe <documentPath> <batchFilePath> [optional: createdFileName]\n");
        return 1;
    }

        char fileName[] = "newBat.bat";

    const char *documentPath = argv[1];
    const char *batchFilePath = argv[2];
    const char *newBatchName = argc == 4 ? argv[3] : fileName;

    FILE *file = fopen(documentPath, "r");
    if (!file) {
        printf("Unable to open file %s\n", documentPath);
        return 1;
    }

    FILE *outputFile = fopen(batchFilePath, "w");
    if (!outputFile) {
        printf("Unable to open file %s\n", batchFilePath);
        return 1;
    }

    char *line;
    while ((line = readLine(file)) != NULL) {
        //process_line(line); // Modify the line
        printf("%s\n", line);
        //trim(&line);
        modifyText(&line);
        printingTemplate(&line, newBatchName);

        fputs(line, outputFile);
        fputc('\n', outputFile);
        printf("%s\n\n",line);
        free(line);
    }

    // Close the files
    fclose(file);
    fclose(outputFile);
        printf("\nRecreating Batch File constructed successfully");
        printf("\nFile to recreate on Execution: \"%s\"", documentPath);
        printf("\nConstructed Batch File for recreating: \"%s\"", batchFilePath);
    return 0;
}
