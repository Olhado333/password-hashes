# Build Stage
FROM ghcr.io/evanrichter/cargo-fuzz:latest AS BUILDER

# Add source code to the build stage.
ADD . /src
WORKDIR /src

# Compile the fuzzers
RUN cd argon2 && cargo +nightly fuzz build
RUN cd balloon-hash && cargo +nightly fuzz build
RUN cd bcrypt-pbkdf && cargo +nightly fuzz build
RUN cd sha-crypt && cargo +nightly fuzz build

# Package stage
FROM ubuntu:latest AS PACKAGE

# Copy the fuzzers to the final image
COPY --from=BUILDER /src/argon2/fuzz/target/x86_64-unknown-linux-gnu/release/fuzz_* /fuzzers/
COPY --from=BUILDER /src/balloon-hash/fuzz/target/x86_64-unknown-linux-gnu/release/fuzz_* /fuzzers/
COPY --from=BUILDER /src/bcrypt-pbkdf/fuzz/target/x86_64-unknown-linux-gnu/release/fuzz_* /fuzzers/
COPY --from=BUILDER /src/sha-crypt/fuzz/target/x86_64-unknown-linux-gnu/release/fuzz_* /fuzzers/